using System.Collections.Generic;

namespace Exercise_1.MovieRentalModel
{
    public class Genre
    {
        public Genre()
        {
            Videos = new List<Video>();
        }
        public int Id { get; set; }
        public string Name { get; set; }
        public IList<Video> Videos { get; set; }
    }
}
