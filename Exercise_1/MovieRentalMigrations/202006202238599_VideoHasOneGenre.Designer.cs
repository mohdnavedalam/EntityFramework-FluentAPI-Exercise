﻿// <auto-generated />
namespace Exercise_1.MovieRentalMigrations
{
    using System.CodeDom.Compiler;
    using System.Data.Entity.Migrations;
    using System.Data.Entity.Migrations.Infrastructure;
    using System.Resources;
    
    [GeneratedCode("EntityFramework.Migrations", "6.4.4")]
    public sealed partial class VideoHasOneGenre : IMigrationMetadata
    {
        private readonly ResourceManager Resources = new ResourceManager(typeof(VideoHasOneGenre));
        
        string IMigrationMetadata.Id
        {
            get { return "202006202238599_VideoHasOneGenre"; }
        }
        
        string IMigrationMetadata.Source
        {
            get { return null; }
        }
        
        string IMigrationMetadata.Target
        {
            get { return Resources.GetString("Target"); }
        }
    }
}