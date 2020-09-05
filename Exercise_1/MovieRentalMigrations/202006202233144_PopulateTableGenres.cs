namespace Exercise_1.MovieRentalMigrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class PopulateTableGenres : DbMigration
    {
        public override void Up()
        {

            Sql("INSERT INTO Genres VALUES ('Action')");
            Sql("INSERT INTO Genres VALUES ('Sci-Fi')");
            Sql("INSERT INTO Genres VALUES ('Comedy')");
        }

        public override void Down()
        {
        }
    }
}
