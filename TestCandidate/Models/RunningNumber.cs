using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace TestCandidate.Models
{
    public class RunningNumber
    {
        public int Year { get; set; }
        public int RunningMonth { get; set; }
        public string Prefix { get; set; }
        public int CurrentNo { get; set; }
    }
}
