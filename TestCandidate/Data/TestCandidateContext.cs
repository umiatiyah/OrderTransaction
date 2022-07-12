using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using TestCandidate.Models;

namespace TestCandidate.Data
{
    public class TestCandidateContext : DbContext
    {
        public TestCandidateContext(DbContextOptions<TestCandidateContext> options) : base(options)
        {
        }

        public DbSet<Order> Orders { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<OrderDetails> OrderDetails { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Order>()
                .Ignore(x => x.OrderDetails)
                .ToTable("Orders");
            modelBuilder.Entity<Customer>().ToTable("Customers");
            modelBuilder.Entity<Product>().ToTable("Products");
            modelBuilder.Entity<OrderDetails>(builder => {
                builder.HasNoKey();
                builder.ToTable("Order Details");
            });
        }
    }
}
