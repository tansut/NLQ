using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JDash.Analytics.NLP
{
    public class GrammarHandler
    {
        private string[] m_metaData;
        private string readMeText = "";

        public GrammarHandler(string[] metaData)
        {
            this.m_metaData = metaData;

            foreach (string i in m_metaData)
            {
                readMeText = readMeText + "'" + i + "'" + " | ";

                if (i.ToLower() != i)
                {
                    readMeText += "'" + i.ToLower() + "'" + " | ";
                }

            }
            readMeText = readMeText.Remove(readMeText.Length - 2, 1);
            readMeText = readMeText + ";";

            if (!Directory.Exists("C:\\Temp"))
                Directory.CreateDirectory("C:\\Temp");

        }

        public string CreateGrammarFile(string fileName)
        {
            using (StreamWriter writetext = new StreamWriter("C:\\Temp\\" + fileName + ".g4"))
            {
                writetext.WriteLine("grammar " + fileName + "; ");
                writetext.WriteLine("options {  language=CSharp_v4_5; }");
                writetext.WriteLine(" r  : v q t;");
                writetext.WriteLine("q  : ((measure)+ (aggregation)* (l)*)+ x + y ;");
                writetext.WriteLine(" x: 'by' (dimension)*;");
                writetext.WriteLine("y: 'filter by' (e)* | 'pivot by' (k)* | 'Filter by' (e)*  | 'Pivot by' (k)*  ;");
                writetext.WriteLine("l:'and'| 'And' | 'AND' | '';");
                writetext.WriteLine("measure:" + readMeText);
                writetext.WriteLine("dimension:" + readMeText);
                writetext.WriteLine("k:" + readMeText);
                writetext.WriteLine("v:'Visualize'| 'Show'| 'Calculate' | 'Show me' | 'visualize' | 'show' | 'calculate' ;");
                writetext.WriteLine("e:" + readMeText);
                writetext.WriteLine("aggregation: 'Sum' | 'Average'| 'Max' | 'Min' | 'sum' | 'average' | 'max' | 'min' ;");
                writetext.WriteLine("t: 'using' gt;");
                writetext.WriteLine("gt: 'Column' | 'Pie' | 'column'| 'pie'| 'bar' | 'Bar' | 'area' | 'Area' | 'Line' | 'line' | 'Chart' | 'chart' ;");
                writetext.WriteLine("WS	:	' ' -> channel(HIDDEN);");
            }

            return "C:\\Temp\\" + fileName + ".g4";
        }

    }
}
