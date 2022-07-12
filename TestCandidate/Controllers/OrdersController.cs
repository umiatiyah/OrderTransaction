using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using TestCandidate.Data;
using TestCandidate.Models;

namespace TestCandidate.Controllers
{
    public class OrdersController : Controller
    {
        private readonly TestCandidateContext _context;

        public OrdersController(TestCandidateContext context)
        {
            _context = context;
        }

        // GET: Orders
        public async Task<IActionResult> Index()
        {
            var testCandidateContext = _context.Orders
                .Include(o => o.Customer);
            return View(await testCandidateContext.ToListAsync());
        }

        // GET: Orders/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var order = await _context.Orders
                .Include(o => o.Customer)
                .FirstOrDefaultAsync(m => m.OrderID == id);

            var detail = await _context.OrderDetails
                .Include(o => o.Product)
                .Where(x => x.OrderID == order.OrderID)
                .ToListAsync();
            foreach (var item in detail)
            {
                Order rd = new Order()
                {
                    OrderDetails = new OrderDetails()
                    {
                        Product = new Product()
                        {
                            ProductName = item.Product.ProductName
                        },
                        UnitPrice = item.Product.UnitPrice,
                        Quantity = item.Product.UnitsOnOrder,
                        Discount = item.Discount
                    },
                };
                order.OrderDetails = rd.OrderDetails;
            };
            if (order == null)
            {
                return NotFound();
            }

            return View(order);
        }

        // GET: Orders/Create
        public IActionResult Create()
        {
            ViewData["CustomerID"] = new SelectList(_context.Customers, "CustomerID", "CustomerID");
            return View();
        }

        // POST: Orders/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("OrderID,OrderNumber,CustomerID,OrderDate,RequiredDate,ShippedDate,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry")] Order order)
        {
            if (ModelState.IsValid)
            {
                var currentNo = await _context.Orders.OrderByDescending(x => x.OrderID).Select(x => x.OrderID).FirstOrDefaultAsync();
                var cust = await _context.Customers.Where(x => x.CustomerID == order.CustomerID).FirstOrDefaultAsync();
                var year = DateTime.Now.Year;
                var month = DateTime.Now.Month;
                var prefix = "ODR";
                currentNo = currentNo + 1;
                var newRunningNumber = $"{prefix}/{year}/{month}/{currentNo}";
                order.OrderNumber = newRunningNumber;
                order.ShipAddress = cust.Address;
                order.ShipCity = cust.City;
                order.ShipCountry = cust.Country;
                order.ShipName = cust.ContactName;
                order.ShipPostalCode = cust.PostalCode;
                order.ShipRegion = cust.Region;
                _context.Add(order);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["CustomerID"] = new SelectList(_context.Customers, "CustomerID", "CustomerID", order.CustomerID);
            return View(order);
        }

        // GET: Orders/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var order = await _context.Orders.FindAsync(id);
            if (order == null)
            {
                return NotFound();
            }
            ViewData["CustomerID"] = new SelectList(_context.Customers, "CustomerID", "CustomerID", order.CustomerID);
            return View(order);
        }

        // POST: Orders/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("OrderID,OrderNumber,CustomerID,OrderDate,RequiredDate,ShippedDate,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry")] Order order)
        {
            if (id != order.OrderID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(order);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!OrderExists(order.OrderID))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["CustomerID"] = new SelectList(_context.Customers, "CustomerID", "CustomerID", order.CustomerID);
            return View(order);
        }

        // GET: Orders/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var order = await _context.Orders
                .Include(o => o.Customer)
                .FirstOrDefaultAsync(m => m.OrderID == id);
            if (order == null)
            {
                return NotFound();
            }

            return View(order);
        }

        // POST: Orders/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var order = await _context.Orders.FindAsync(id);
            _context.Orders.Remove(order);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool OrderExists(int id)
        {
            return _context.Orders.Any(e => e.OrderID == id);
        }
    }
}
