using System.Data.Entity;
using Exercise_1.EntityConfigurations;

namespace Exercise_1.MovieRentalModel
{
    public class MovieRentalContext : DbContext
    {
        public MovieRentalContext() : base("name=MovieRentalContext") { }

        public DbSet<Video> Videos { get; set; }
        public DbSet<Genre> Genres { get; set; }
        

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new GenreConfiguration());
            modelBuilder.Configurations.Add(new VideoConfiguration());
            modelBuilder.Configurations.Add(new TagConfiguration());
            base.OnModelCreating(modelBuilder);
        }
    }
}
