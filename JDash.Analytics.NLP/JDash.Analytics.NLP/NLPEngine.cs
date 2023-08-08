using Antlr4.Runtime;
using Antlr4.Runtime.Tree;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JDash.Analytics.NLP
{
    public class NLPEngine
    {

        public NLPEngine()
        {

            FileInfo jarFile = new FileInfo(Environment.CurrentDirectory + "\\lib\\antlr4-csharp-4.5-SNAPSHOT-complete.jar");

            DirectoryInfo di = new DirectoryInfo("C:\\Javalib");
            if (!di.Exists)
                di.Create();

            if (!File.Exists(di.FullName + "\\" + jarFile.Name))
            {
                File.WriteAllBytes(di.FullName + "\\" + jarFile.Name, NLP_Resources.antlr4_csharp_4_5_SNAPSHOT_complete);
            }
            else
            {
                if (NLP_Resources.antlr4_csharp_4_5_SNAPSHOT_complete.Length != new FileInfo(di.FullName + "\\" + jarFile.Name).Length)
                {
                    File.WriteAllBytes(di.FullName + "\\" + jarFile.Name, NLP_Resources.antlr4_csharp_4_5_SNAPSHOT_complete);
                }

            }
        }


        public ResultModel GetMDQuery(string[] headers, string query)
        {
            ResultModel model = new ResultModel();

            using (LexerLoader loader = new LexerLoader(headers))
            {
                var lexer = loader.GetLexer(query);
                CommonTokenStream cts = new CommonTokenStream(lexer);
                var parser = loader.GetParser(cts);

                IParseTree tree = (IParseTree)parser.GetType().GetMethod("r").Invoke(parser, null);
                //r(); // begin parsing at init rule
                var my_output = tree.ToStringTree(parser);
                Console.WriteLine(my_output);
                model.Measures = find_measure_aggregation(tree, parser);
                model.Dimensions = find_dimension(my_output);
                model.Filters = find_filterby(my_output);
                model.Pivots = find_pivotby(my_output);
                var graphTypeStr = find_graph(my_output).FirstOrDefault() ?? "";
                switch (graphTypeStr.ToLower())
                {
                    case "bar":
                        model.GraphType = GraphType.Bar;
                        break;
                    case "pie":
                        model.GraphType = GraphType.Pie;
                        break;
                    case "line":
                        model.GraphType = GraphType.Line;
                        break;
                    case "area":
                        model.GraphType = GraphType.Area;
                        break;
                    case "column":
                        model.GraphType = GraphType.Column;
                        break;
                    default:
                        model.GraphType = GraphType.Bar;
                        break;
                }

            }
            return model;

        }

        private IEnumerable<MeasureResultModel> find_measure_aggregation(IParseTree tree, Parser parser)
        {
            List<MeasureResultModel> result = new List<MeasureResultModel>();
            for (int i = 0; i < tree.ChildCount; i++)
            {
                var child = tree.GetChild(i);
                if (child.ToStringTree(parser).StartsWith("(q"))
                {
                    for (int j = 0; j < child.ChildCount; j++)
                    {
                        var measureAggregate = child.GetChild(j);
                        var str = measureAggregate.ToStringTree(parser);

                        if (str.StartsWith("(measure"))
                        {
                            MeasureResultModel model = new MeasureResultModel();
                            model.Name = str.Substring("(measure".Length).Trim().TrimEnd(new[] { ')' });
                            if (child.ChildCount > ++j)
                            {
                                var aggregate = child.GetChild(j).ToStringTree(parser);
                                if (aggregate.StartsWith("(aggregation"))
                                {
                                    model.Aggregation = (AggregationType)Enum.Parse(typeof(AggregationType), aggregate.Substring("(aggregation".Length).Trim().TrimEnd(new[] { ')' }), true);
                                }
                                else
                                {
                                    --j;
                                }
                            }

                            result.Add(model);
                        }
                    }
                }
            }

            return result;
        }

        private IEnumerable<string> find_measure(string my_out)
        {
            List<string> measurements = new List<string>();
            string tobesearched = "measure";
            int ix = my_out.IndexOf(tobesearched);
            int count = 0;
            string my_out2 = my_out;
            while (my_out.Contains("measure"))
            {
                count = count + 1;
                ix = my_out.IndexOf(tobesearched);
                measurements.Add(my_out.Between("measure", ")").Trim());
                if (ix != -1)
                {
                    my_out = my_out.Substring(ix + tobesearched.Length);
                }
            }
            Console.WriteLine("Measures are : ");
            foreach (string i in measurements)
            {
                Console.WriteLine(i);
            }

            return measurements;
        }
        private IEnumerable<string> find_aggregation(string my_out)
        {
            List<string> aggregation = new List<string>();
            string tobesearched = "measure";
            int ix = my_out.IndexOf(tobesearched);
            int count = 0;
            string my_out2 = my_out;
            while (my_out.Contains("measure"))
            {
                count = count + 1;
                ix = my_out.IndexOf(tobesearched);
                aggregation.Add(my_out.Between("measure", ")").Trim());
                if (ix != -1)
                {
                    my_out = my_out.Substring(ix + tobesearched.Length);
                }
            }
            List<string> aggregations = new List<string>();
            string tobesearched2 = "aggregation";
            int ix2 = my_out.IndexOf(tobesearched2);
            int count2 = 0;
            int flag = 0;

            if (aggregation.Capacity > 0 && !my_out.Contains("aggregation") && flag == 0)
            {

                aggregations.Add("Sum");


            }
            while (my_out.Contains("aggregation"))
            {
                flag = 1;
                count2 = count2 + 1;
                // if (my_out.Between("aggregation", ")") == " ")
                //  aggregations.Add("Sum");

                aggregations.Add(my_out.Between("aggregation", ")").Trim());

                if (ix2 != -1)
                {
                    my_out = my_out.Substring(ix + tobesearched.Length);
                }
            }

            Console.WriteLine("Aggregations are : ");
            foreach (string i in aggregations)
            {
                Console.WriteLine(i);
            }

            return aggregations;
        }

        private IEnumerable<string> find_dimension(string my_out)
        {
            List<string> dimensions = new List<string>();
            string tobesearched = "dimension";
            int count = 0;
            string my_out2 = my_out;
            while (my_out.Contains("dimension"))
            {
                count = count + 1;

                dimensions.Add(my_out.Between("dimension", ")").Trim());
                int ix = my_out.IndexOf(tobesearched);
                if (ix != -1)
                {
                    my_out = my_out.Substring(ix + tobesearched.Length);
                }
            }
            Console.WriteLine("Dimensions are : ");
            foreach (string i in dimensions)
            {
                Console.WriteLine(i);
            }
            return dimensions;
        }

        private IEnumerable<string> find_graph(string my_out)
        {
            List<string> graphs = new List<string>();
            string tobesearched = "gt";
            int count = 0;
            string my_out2 = my_out;
            while (my_out.Contains("gt"))
            {
                count = count + 1;

                graphs.Add(my_out.Between("gt", ")").Trim());
                int ix = my_out.IndexOf(tobesearched);
                if (ix != -1)
                {
                    my_out = my_out.Substring(ix + tobesearched.Length);
                }
            }
            Console.WriteLine("Graph as : ");
            foreach (string i in graphs)
            {
                Console.WriteLine(i);
            }
            return graphs;
        }


        private IEnumerable<string> find_filterby(string my_out)
        {
            List<string> filters = new List<string>();
            string tobesearched = "(e";
            int count = 0;
            string my_out2 = my_out;
            while (my_out.Contains("(e"))
            {
                count = count + 1;

                filters.Add(my_out.Between("(e", ")").Trim());
                int ix = my_out.IndexOf(tobesearched);
                if (ix != -1)
                {
                    my_out = my_out.Substring(ix + tobesearched.Length);
                }
            }
            Console.WriteLine("Filters are : ");
            foreach (string i in filters)
            {
                Console.WriteLine(i);
            }
            return filters;
        }

        private IEnumerable<string> find_pivotby(string my_out)
        {
            List<string> pivots = new List<string>();
            string tobesearched = "(k";
            int count = 0;
            string my_out2 = my_out;
            while (my_out.Contains("(k"))
            {
                count = count + 1;

                pivots.Add(my_out.Between("(k", ")").Trim());
                int ix = my_out.IndexOf(tobesearched);
                if (ix != -1)
                {
                    my_out = my_out.Substring(ix + tobesearched.Length);
                }
            }
            Console.WriteLine("Pivot by : ");
            foreach (string i in pivots)
            {
                Console.WriteLine(i);
            }
            return pivots;
        }
    }
    static class SubstringExtensions
    {
        /// <summary>
        /// Get string value between [first] a and [last] b.
        /// </summary>
        public static string Between(this string value, string a, string b)
        {
            int posA = value.IndexOf(a);
            int ix = value.IndexOf(a);
            if (ix != -1)
            {
                value = value.Substring(ix + a.Length);
                //     Console.WriteLine(my_out);
            }
            // Console.WriteLine("value after measure");
            //Console.WriteLine(value);
            return value.Before(b);
        }

        /// <summary>
        /// Get string value after [first] a.
        /// </summary>
        public static string Before(this string value, string a)
        {
            int posA = value.IndexOf(a);
            if (posA == -1)
            {
                return "";
            }
            return value.Substring(0, posA);
        }

        /// <summary>
        /// Get string value after [last] a.
        /// </summary>
        public static string After(this string value, string a)
        {
            int posA = value.LastIndexOf(a);
            if (posA == -1)
            {
                return "";
            }
            int adjustedPosA = posA + a.Length;
            if (adjustedPosA >= value.Length)
            {
                return "";
            }
            return value.Substring(adjustedPosA);
        }

    }
}
