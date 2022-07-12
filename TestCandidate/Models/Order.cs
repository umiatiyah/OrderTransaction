using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace TestCandidate.Models
{
    public class Order
    {
        public int OrderID { get; set; }
        public string OrderNumber { get; set; }
        public string CustomerID { get; set; }
        public DateTime OrderDate { get; set; }
        public DateTime RequiredDate { get; set; }
        public DateTime ShippedDate { get; set; }
        public decimal Freight { get; set; }
        public string ShipName { get; set; }
        public string ShipAddress { get; set; }
        public string ShipCity { get; set; }
        public string ShipRegion { get; set; }
        public string ShipPostalCode { get; set; }
        public string ShipCountry { get; set; }
        public Customer Customer { get; set; }
        public List<OrderDetails> OrderDetails { get; set; }
    }
}
