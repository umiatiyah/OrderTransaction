using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace TestCandidate.Models
{
    public class OrderDetails
    {
        [ForeignKey("OrderID")]
        public int OrderID { get; set; }
        [ForeignKey("ProductID")]
        public int ProductID { get; set; }
        public decimal UnitPrice { get; set; }
        public Int16 Quantity { get; set; }
        public float Discount { get; set; }
        public Product Product { get; set; }
        public Order Order { get; set; }
    }
}
