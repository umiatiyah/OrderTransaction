using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TestCandidate.Models;

namespace TestCandidate.Data
{
    public static class DbInitializer
    {
        public static void Initialize(TestCandidateContext context)
        {
            context.Database.EnsureCreated();

            // Look for any Customers.
            if (context.Customers.Any())
            {
                return;   // DB has been seeded
            }

            var customers = new Customer[]
            {
                new Customer{
                    CustomerID="MTSU",
                    CompanyName="MTSU",
                    ContactName="mtsu",
                    ContactTitle="title",
                    Address="Bekasi",
                    City="Bekasi",
                    Region="Jawa Barat",
                    PostalCode="17510",
                    Country="Indonesia",
                    Phone="0812",
                    Fax="123",
                }
            };
            foreach (Customer s in customers)
            {
                context.Customers.Add(s);
            }
            context.SaveChanges();
        }
    }
}
