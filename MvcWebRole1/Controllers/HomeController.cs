using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using MvcWebRole1.Models;

namespace MvcWebRole1.Controllers
{
	[HandleError]
	public partial class HomeController : Controller
	{
		public virtual ActionResult Index()
		{
			return View();
		}

		[HttpGet]
		public virtual ActionResult Solve()
		{
			return View();
		}

		[HttpPost]
		public virtual ActionResult Solve(int? sum, int? count, string include, string exclude)
		{
			if (sum.HasValue && count.HasValue)
			{
				return Json(SolveInternal(sum.Value, count.Value, include, exclude));
			}

			return new EmptyResult();
		}

		private SolveResultModel SolveInternal(int sum, int count, string include, string exclude)
		{
			IEnumerable<int> includes = new List<int>();
			IEnumerable<int> excludes = new List<int>();

			var result = new SolveResultModel();
			includes = include.Select(f => (int)(f - '0')).Distinct().OrderBy(f => f); 
			excludes = exclude.Select(f => (int)(f - '0')).Distinct().OrderBy(f => f); 

			var solutions = Solve(sum, count, includes, excludes).ToList();

			result.Common = solutions.SelectMany(f => f).Distinct()
					.Where(f => !solutions.Any(x => !x.Contains(f)))
					.OrderBy(f => f);

			result.Sets = solutions.Select(x => x.Except(result.Common));

			return result;
		}

		private static IEnumerable<IEnumerable<int>> Solve(int sum, int count, IEnumerable<int> includes, IEnumerable<int> excludes)
		{
			var solutions = new List<IEnumerable<int>>();
			var all = Enumerable.Range(1, 9).ToList();
			if (count == 1)
			{
				if (all.Contains(sum) && !includes.Any(f => f != sum) && !excludes.Contains(sum))
					solutions.Add(new List<int>() { sum });
			}
			else if (count > 1)
			{
				foreach (int part in all.Except(excludes).Where(f => f < sum))
				{
					IEnumerable<IEnumerable<int>> partialSolutions = Solve(sum - part, count - 1, includes.Where(f => f != part), excludes.Concat(new List<int>() { part }));
					foreach (var partialSolution in partialSolutions)
					{
						IEnumerable<int> solution = new List<int>() { part }.Concat(partialSolution).OrderBy(f => f);
						if (!solutions.Any(f => f.SequenceEqual(solution)))
							solutions.Add(solution);
					}
				}
			}
			return solutions;
		}

	}
}
