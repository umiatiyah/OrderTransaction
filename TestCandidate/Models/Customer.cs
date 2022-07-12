using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace TestCandidate.Models
{
    public class Customer
    {
        [Required, StringLength(5)]
        public string CustomerID { get; set; }
        [Required, StringLength(40, MinimumLength = 3)]
        public string CompanyName { get; set; }
        [Required, StringLength(30, MinimumLength = 3)]
        public string ContactName { get; set; }
        public string ContactTitle { get; set; }
        [Required, StringLength(60, MinimumLength = 3)]
        public string Address { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string PostalCode { get; set; }
        public string Country { get; set; }
        [Required, StringLength(24, MinimumLength = 8)]
        public string Phone { get; set; }
        public string Fax { get; set; }
    }
}
