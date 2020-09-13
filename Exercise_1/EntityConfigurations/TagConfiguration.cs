using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity.ModelConfiguration;

using Exercise_1.MovieRentalModel;

namespace Exercise_1.EntityConfigurations
{
    class TagConfiguration : EntityTypeConfiguration<Tag>
    {
        public TagConfiguration()
        {
            Property(t => t.Name).IsRequired().HasMaxLength(255);
        }
    }
}
