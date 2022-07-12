using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using TestCandidate.Data;
using TestCandidate.Models;
using Dapper;

namespace TestCandidate.Controllers
{
    public class OrderDetailsController : Controller
    {
        private readonly TestCandidateContext _context;

        public OrderDetailsController(TestCandidateContext context)
        {
            _context = context;
        }

        // GET: OrderDetails
        public async Task<IActionResult> Index()
        {
            var testCandidateContext = _context.OrderDetails.Include(o => o.Order).Include(x => x.Product);
            return View(await testCandidateContext.ToListAsync());
        }

        // GET: OrderDetails/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var orderDetails = await _context.OrderDetails
                .Include(o => o.Order)
                .FirstOrDefaultAsync(m => m.ProductID == id);
            if (orderDetails == null)
            {
                return NotFound();
            }

            return View(orderDetails);
        }

        // GET: OrderDetails/Create
        public IActionResult Create()
        {
            ViewData["OrderID"] = new SelectList(_context.Orders, "OrderID", "OrderNumber");
            ViewData["ProductID"] = new SelectList(_context.Products, "ProductID", "ProductName");
            return View();
        }

        // POST: OrderDetails/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("OrderID,ProductID,UnitPrice,Quantity,Discount")] OrderDetails orderDetails)
        {
            if (ModelState.IsValid)
            {
                var product = await _context.Products.Where(x => x.ProductID == orderDetails.ProductID).FirstOrDefaultAsync();
                var order = await _context.Orders.Where(x => x.OrderID == orderDetails.OrderID).FirstOrDefaultAsync();
                using (var con = this._context.Connection)
                {
                    con.Query<OrderDetails>("INSERT INTO [dbo].[Order Details] ([OrderID],[ProductID],[UnitPrice],[Quantity],[Discount])"
                        + "VALUES (@OrderID, @ProductID, @UnitPrice, @Quantity, @Discount)", 
                        new
                    {
                            OrderID = order?.OrderID,
                            ProductID = product?.ProductID,
                            UnitPrice = product?.UnitPrice,
                            Quantity = product?.UnitsOnOrder,
                            Discount = orderDetails.Discount
                    });
                }
//                _context.Add(orderDetails);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(OrdersController.Index));
            }
            ViewData["OrderID"] = new SelectList(_context.Orders, "OrderID", "OrderID", orderDetails.OrderID);
            ViewData["ProductID"] = new SelectList(_context.Products, "ProductID", "ProductID", orderDetails.ProductID);
            return RedirectToAction(nameof(OrdersController.Index));
        }

        // GET: OrderDetails/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var orderDetails = await _context.OrderDetails.FindAsync(id);
            if (orderDetails == null)
            {
                return NotFound();
            }
            ViewData["OrderID"] = new SelectList(_context.Orders, "OrderID", "ShipAddress", orderDetails.OrderID);
            return View(orderDetails);
        }

        // POST: OrderDetails/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("OrderID,ProductID,UnitPrice,Quantity,Discount")] OrderDetails orderDetails)
        {
            if (id != orderDetails.ProductID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(orderDetails);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!OrderDetailsExists(orderDetails.ProductID))
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
            ViewData["OrderID"] = new SelectList(_context.Orders, "OrderID", "ShipAddress", orderDetails.OrderID);
            return View(orderDetails);
        }

        // GET: OrderDetails/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var orderDetails = await _context.OrderDetails
                .Include(o => o.Order)
                .FirstOrDefaultAsync(m => m.ProductID == id);
            if (orderDetails == null)
            {
                return NotFound();
            }

            return View(orderDetails);
        }

        // POST: OrderDetails/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var orderDetails = await _context.OrderDetails.FindAsync(id);
            _context.OrderDetails.Remove(orderDetails);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool OrderDetailsExists(int id)
        {
            return _context.OrderDetails.Any(e => e.ProductID == id);
        }
    }
}
