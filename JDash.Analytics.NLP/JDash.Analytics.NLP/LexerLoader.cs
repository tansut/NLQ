using Antlr4.Runtime;
using Microsoft.CSharp;
using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace JDash.Analytics.NLP
{
    public class LexerLoader : IDisposable
    {
        private string[] headers;
        private string lexerPath;
        private string parserPath;
        private string listenerPath;
        private string rawName;
        private DirectoryInfo workingDirectory;
        public LexerLoader(string[] headerText)
        {
            this.headers = headerText;

            List<string> HeaderList = headers.Select(d => "" + d + "").ToList();
            GrammarHandler handler = new GrammarHandler(HeaderList.ToArray());
            var fileName = "a" + Guid.NewGuid().ToString("n");
            var fileAdress = handler.CreateGrammarFile(fileName);
            Process cmd = new Process();
            cmd.StartInfo.FileName = "cmd.exe";
            cmd.StartInfo.RedirectStandardInput = true;
            cmd.StartInfo.RedirectStandardOutput = true;
            cmd.StartInfo.CreateNoWindow = true;
            cmd.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
 
            cmd.StartInfo.UseShellExecute = false;
            cmd.Start();
            cmd.StandardInput.WriteLine(@"SET CLASSPATH=.;C:\Javalib\antlr4-csharp-4.5-SNAPSHOT-complete.jar;%CLASSPATH%");
            cmd.StandardInput.Write(cmd.StandardInput.NewLine);
            cmd.StandardInput.Flush();
            cmd.StandardInput.WriteLine(@"java org.antlr.v4.Tool " + fileAdress);
            cmd.StandardInput.Flush();
            cmd.StandardInput.Write("exit");
            cmd.StandardInput.Flush();
            cmd.EnableRaisingEvents = true;

            FileInfo fi = new FileInfo(fileAdress);
            workingDirectory = fi.Directory;
            var rawAdress = rawName = fileAdress.Replace(".g4", "");
            var lexerAdress = rawAdress + "Lexer.cs";
            var parserAdress = rawAdress + "Parser.cs";

            this.listenerPath = rawAdress + "Listener.cs";
            this.parserPath = parserAdress;
            this.lexerPath = lexerAdress;

            cmd.Close();
            int timeout = 6000;
            int passedTime = 0;
            do
            {
                System.Threading.Thread.Sleep(50);
                passedTime += 50;
            } while (!(File.Exists(lexerAdress) && File.Exists(listenerPath)) && passedTime < timeout);


        }

        public Lexer GetLexer(string input)
        {
            var alltext = File.ReadAllText(lexerPath);
            File.WriteAllText(lexerPath, alltext);
            var assembly = CompileCode(lexerPath, false);
            var lexerType = assembly.DefinedTypes.FirstOrDefault(d => d.Name.EndsWith("Lexer"));
            var inputStream = new Antlr4.Runtime.AntlrInputStream(input);
            var result = (Lexer)Activator.CreateInstance(lexerType, inputStream);
            return result;
        }


        public Antlr4.Runtime.Parser GetParser(CommonTokenStream tokenStream)
        {

            var listenerText = File.ReadAllText(listenerPath);
            Regex regex = new Regex("using .*;");
            var alltext = File.ReadAllText(parserPath);
            alltext += Environment.NewLine + listenerText;
            alltext = regex.Replace(alltext, "");

            var usings = @"using System;
using Antlr4.Runtime;
using Antlr4.Runtime.Atn;
using Antlr4.Runtime.Misc;
using DFA = Antlr4.Runtime.Dfa.DFA;
using System.Text;
using System.Diagnostics;
using System.Collections.Generic;
using Antlr4.Runtime.Tree;
";


            alltext = usings + alltext;

            File.WriteAllText(parserPath, alltext);

            var assembly = CompileCode(parserPath, false);
            var lexerType = assembly.DefinedTypes.FirstOrDefault(d => d.Name.EndsWith("Parser"));
            var result = (Antlr4.Runtime.Parser)Activator.CreateInstance(lexerType, tokenStream);
            return result;
        }

        private Assembly CompileCode(String sourceName, bool asDll)
        {
            FileInfo sourceFile = new FileInfo(sourceName);
            CodeDomProvider provider = null;

            if (sourceFile.Extension.ToUpper(CultureInfo.InvariantCulture) == ".CS")
            {
                provider = CodeDomProvider.CreateProvider("CSharp");
            }
            else if (sourceFile.Extension.ToUpper(CultureInfo.InvariantCulture) == ".VB")
            {
                provider = CodeDomProvider.CreateProvider("VisualBasic");
            }

            if (provider != null)
            {
                CompilerParameters cp = new CompilerParameters();
                cp.GenerateExecutable = false;

                if (asDll)
                {
                    cp.GenerateInMemory = false;
                    cp.OutputAssembly = "nabre";
                }
                else
                {

                    cp.GenerateInMemory = true;
                }

                cp.TreatWarningsAsErrors = false;
                cp.ReferencedAssemblies.Add(typeof(String).Assembly.Location);
                cp.ReferencedAssemblies.Add(typeof(System.CodeDom.CodeArgumentReferenceExpression).Assembly.Location);
                cp.ReferencedAssemblies.Add(typeof(AntlrFileStream).Assembly.Location);

                CompilerResults cr = provider.CompileAssemblyFromFile(cp,
                    sourceName);

                if (cr.Errors.Count > 0)
                {
                    Console.WriteLine("Errors building {0} into {1}",
                        sourceName, cr.PathToAssembly);
                    foreach (CompilerError ce in cr.Errors)
                    {
                        Console.WriteLine("  {0}", ce.ToString());
                        Console.WriteLine();
                    }
                }
                else
                {
                    Console.WriteLine("Source {0} built into {1} successfully.",
                        sourceName, cr.CompiledAssembly.FullName);
                }

                return cr.CompiledAssembly;
            }
            return null;
        }


        private string Before(string value, string a)
        {
            int posA = value.IndexOf(a);
            if (posA == -1)
            {
                return "";
            }
            return value.Substring(0, posA);
        }


        private string Between(string value, string a, string b)
        {
            int posA = value.IndexOf(a);
            int ix = value.IndexOf(a);
            if (ix != -1)
            {
                value = value.Substring(ix + a.Length);
                //     Console.WriteLine(my_out);
            }
            return Before(value, b);
        }


        private void ManupulateHeader(string Headers, List<string> HeaderList)
        {
            Headers = "," + Headers + ",";
            string tobesearched = ",";
            int count = 0;
            while (Headers.Contains(","))
            {
                count = count + 1;
                HeaderList.Add(Between(Headers, ",", ","));
                int ix = Headers.IndexOf(tobesearched);
                if (ix != -1)
                {
                    Headers = Headers.Substring(ix + tobesearched.Length);
                }
            }

        }

        public void Dispose()
        {
            var tempFiles = workingDirectory.GetFiles().Where(d =>
             (d.Extension == ".cs"
             || d.Extension == ".tokens"
             || d.Extension == ".g4"
             )
             && d.FullName.StartsWith(rawName)
              ).ToList();

            foreach (var file in tempFiles)
            {
                file.Delete();
            }
        }
    }
}
