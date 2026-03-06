using Microsoft.EntityFrameworkCore;
using SmartWasteManagement.Models;

namespace SmartWasteManagement.Data
{
    public static class DbSeeder
    {
        public static void Seed(AppDbContext db)
        {
            // Migrate any pending migrations first
            db.Database.Migrate();

            // Seed Admin if not exists
            if (!db.Users.Any(u => u.Email == "admin@waste.com"))
            {
                db.Users.Add(new User
                {
                    Name = "Admin",
                    Email = "admin@waste.com",
                    PasswordHash = BCrypt.Net.BCrypt.HashPassword("Admin@123"),
                    Role = UserRole.Admin,
                    ZoneId = null
                });

                db.SaveChanges();
            }
        }
    }
}