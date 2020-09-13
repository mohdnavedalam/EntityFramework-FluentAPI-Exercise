using System;
using System.Collections.Generic;

namespace Exercise_1.MovieRentalModel
{
    public class Video
    {
        public Video()
        {
            //    this.Genres = new List<Genre>();
            Tags = new List<Tag>();
        }        
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime ReleaseDate { get; set; }
        //public IList<Genre> Genres { get; set; }
        public Genre Genre { get; set; }
        public Classification Classification { get; set; }
        public IList<Tag> Tags { get; set; }
    }
}
