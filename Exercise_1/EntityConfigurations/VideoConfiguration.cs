using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity.ModelConfiguration;

using Exercise_1.MovieRentalModel;

namespace Exercise_1.EntityConfigurations
{
    class VideoConfiguration : EntityTypeConfiguration<Video>
    {
        public VideoConfiguration()
        {
            Property(v => v.Name).IsRequired().HasMaxLength(255);

            HasRequired(v => v.Genre).WithMany(g => g.Videos)
                .Map(m =>
                {
                    m.ToTable("Videos");
                    m.MapKey("GenreID");
                });

            HasMany(v => v.Tags).WithMany(t => t.Videos)
                .Map(m =>
                {
                    m.ToTable("VideoTags");
                    m.MapLeftKey("VideoID");
                    m.MapRightKey("TagID");
                });
        }
    }
}
