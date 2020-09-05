namespace Exercise_1.MovieRentalMigrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class TableVideosColumnGenreIDNameChange : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.Videos", "Genre_Id", "dbo.Genres");
            DropIndex("dbo.Videos", new[] { "Genre_Id" });
            RenameColumn(table: "dbo.Videos", name: "Genre_Id", newName: "GenreID");
            AlterColumn("dbo.Videos", "GenreID", c => c.Int(nullable: false));
            CreateIndex("dbo.Videos", "GenreID");
            AddForeignKey("dbo.Videos", "GenreID", "dbo.Genres", "Id", cascadeDelete: true);
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Videos", "GenreID", "dbo.Genres");
            DropIndex("dbo.Videos", new[] { "GenreID" });
            AlterColumn("dbo.Videos", "GenreID", c => c.Int());
            RenameColumn(table: "dbo.Videos", name: "GenreID", newName: "Genre_Id");
            CreateIndex("dbo.Videos", "Genre_Id");
            AddForeignKey("dbo.Videos", "Genre_Id", "dbo.Genres", "Id");
        }
    }
}
