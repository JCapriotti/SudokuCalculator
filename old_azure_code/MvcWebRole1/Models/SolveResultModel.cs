using System.Collections.Generic;

namespace MvcWebRole1.Models
{
	public class SolveResultModel
	{
		public IEnumerable<int> Common { get; set; }
		public IEnumerable<IEnumerable<int>> Sets { get; set; }
	}
}