using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exercise_1.MovieRentalModel
{
    class Tag
    {
        Tag()
        {
            Videos = new List<Video>();
        }
        public int ID { get; set; }
        public string Name { get; set; }
        public IList<Video> Videos { get; set; }
    }
}
