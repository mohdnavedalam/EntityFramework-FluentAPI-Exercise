namespace Exercise_1.MovieRentalMigrations
{
    using System;
    using System.Data.Entity;
    using System.Collections.Generic;
    using System.Data.Entity.Migrations;
    using System.Linq;

    using Exercise_1.MovieRentalModel;
    

    internal sealed class Configuration : DbMigrationsConfiguration<MovieRentalContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
            MigrationsDirectory = @"MovieRentalMigrations";
        }

        protected override void Seed(MovieRentalContext context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method
            //  to avoid creating duplicate seed data.

            context.Genres.AddOrUpdate(g => g.Id, new Genre
            {
                Id = 4,
                Name = "Horror",
            });

            context.Genres.AddOrUpdate(g => g.Id, new Genre
            {
                Id = 5,
                Name = "Thriller",
            });

            context.Genres.AddOrUpdate(g => g.Id, new Genre
            {
                Id = 6,
                Name = "Family",
            });

            context.Genres.AddOrUpdate(g => g.Id, new Genre
            {
                Id = 7,
                Name = "Romance",
            });

            context.Videos.AddOrUpdate(v => v.Id, new Video
            {
                Id = 1,
                Name = "The Godfather",
                ReleaseDate = new DateTime(1972, 3, 24),
                Classification = Classification.Platinum,
                GenreId = 7
            });

            context.Videos.AddOrUpdate(v => v.Id, new Video
            {
                Id = 2,
                Name = "The Shawshank Redemption",
                ReleaseDate = new DateTime(1994, 9, 14),
                Classification = Classification.Gold,
                GenreId = 7
            });

            context.Videos.AddOrUpdate(v => v.Id, new Video
            {
                Id = 3,
                Name = "Schindler's List",
                ReleaseDate = new DateTime(1994, 2, 4),
                Classification = Classification.Gold,
                GenreId = 7
            });

            context.Videos.AddOrUpdate(v => v.Id, new Video
            {
                Id = 4,
                Name = "The Hangover",
                ReleaseDate = new DateTime(2009, 6, 11),
                Classification = Classification.Gold,
                GenreId = 1
            });

            context.Videos.AddOrUpdate(v => v.Id, new Video
            {
                Id = 5,
                Name = "Anchorman",
                ReleaseDate = new DateTime(2004, 4, 11),
                Classification = Classification.Silver,
                GenreId = 1
            });

            context.Videos.AddOrUpdate(v => v.Id, new Video
            {
                Id = 6,
                Name = "Die Hard",
                ReleaseDate = new DateTime(1988, 6, 13),
                Classification = Classification.Gold,
                GenreId = 2
            });

            context.Videos.AddOrUpdate(v => v.Id, new Video
            {
                Id = 7,
                Name = "The Dark Knight",
                ReleaseDate = new DateTime(2008, 1, 5),
                Classification = Classification.Gold,
                GenreId = 2
            });

            context.Videos.AddOrUpdate(v => v.Id, new Video
            {
                Id = 8,
                Name = "Terminator 2: Judgment Day",
                ReleaseDate = new DateTime(1991, 5, 15),
                Classification = Classification.Platinum,
                GenreId = 2
            });
        }
    }
}
