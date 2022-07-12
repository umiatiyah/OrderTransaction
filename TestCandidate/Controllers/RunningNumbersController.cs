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
    public class RunningNumbersController : Controller
    {
        private readonly TestCandidateContext _context;

        public RunningNumbersController(TestCandidateContext context)
        {
            _context = context;
        }

        // GET: RunningNumbers
        public async Task<IActionResult> Index()
        {
            return View(await _context.RunningNumbers.ToListAsync());
        }

        // GET: RunningNumbers/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var runningNumber = await _context.RunningNumbers
                .FirstOrDefaultAsync(m => m.RunningMonth == id);
            if (runningNumber == null)
            {
                return NotFound();
            }

            return View(runningNumber);
        }

        // GET: RunningNumbers/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: RunningNumbers/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Year,RunningMonth,Prefix,CurrentNo")] RunningNumber runningNumber)
        {
            if (ModelState.IsValid)
            {
                _context.Add(runningNumber);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(runningNumber);
        }

        // GET: RunningNumbers/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var runningNumber = await _context.RunningNumbers.FindAsync(id);
            if (runningNumber == null)
            {
                return NotFound();
            }
            return View(runningNumber);
        }

        // POST: RunningNumbers/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Year,RunningMonth,Prefix,CurrentNo")] RunningNumber runningNumber)
        {
            if (id != runningNumber.RunningMonth)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(runningNumber);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!RunningNumberExists(runningNumber.RunningMonth))
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
            return View(runningNumber);
        }

        // GET: RunningNumbers/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var runningNumber = await _context.RunningNumbers
                .FirstOrDefaultAsync(m => m.RunningMonth == id);
            if (runningNumber == null)
            {
                return NotFound();
            }

            return View(runningNumber);
        }

        // POST: RunningNumbers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var runningNumber = await _context.RunningNumbers.FindAsync(id);
            _context.RunningNumbers.Remove(runningNumber);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool RunningNumberExists(int id)
        {
            return _context.RunningNumbers.Any(e => e.RunningMonth == id);
        }
    }
}
