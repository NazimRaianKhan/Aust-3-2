using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi;
//using Microsoft.OpenApi.Models;
using SmartWasteManagement.Data;
using SmartWasteManagement.Helpers;
using SmartWasteManagement.Interfaces;
using SmartWasteManagement.Services;
using System.Text;

namespace SmartWasteManagement
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // ── Database ──────────────────────────────────────────────────────
            builder.Services.AddDbContext<AppDbContext>(options =>
                options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

            // ── JWT Authentication ────────────────────────────────────────────
            builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(options =>
                {
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = new SymmetricSecurityKey(
                            Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]!)),
                        ValidateIssuer = true,
                        ValidIssuer = builder.Configuration["Jwt:Issuer"],
                        ValidateAudience = true,
                        ValidAudience = builder.Configuration["Jwt:Audience"],
                        ValidateLifetime = true
                    };
                });

            builder.Services.AddAuthorization();

            // ── Helpers ───────────────────────────────────────────────────────
            builder.Services.AddScoped<JwtHelper>();

            // ── Services (Interface → Implementation) ─────────────────────────
            builder.Services.AddScoped<IAuthService, AuthService>();
            builder.Services.AddScoped<IUserService, UserService>();
            builder.Services.AddScoped<IZoneService, ZoneService>();
            builder.Services.AddScoped<IWasteReportService, WasteReportService>();
            builder.Services.AddScoped<IScheduleService, ScheduleService>();
            builder.Services.AddScoped<ICollectionLogService, CollectionLogService>();
            builder.Services.AddScoped<IAdminService, AdminService>();

            builder.Services.AddControllers();

            // ── Swagger (Swashbuckle 10 + Microsoft.OpenApi 3.x syntax) ───────
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen(options =>
            {
                options.SwaggerDoc("v1", new OpenApiInfo
                {
                    Title = "Smart Waste Management API",
                    Version = "v1",
                    Description = "Backend API for Smart Waste Management System"
                });

                // Step 1: Define the Bearer scheme
                options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
                {
                    Name = "Authorization",
                    Description = "Enter your JWT token. Example: Bearer eyJhbGci...",
                    In = ParameterLocation.Header,
                    Type = SecuritySchemeType.Http,
                    Scheme = "bearer",
                    BearerFormat = "JWT"
                });

                // Step 2: Require it globally using the NEW delegate pattern (Swashbuckle 10)
                options.AddSecurityRequirement(document => new OpenApiSecurityRequirement
                {
                    [new OpenApiSecuritySchemeReference("Bearer", document)] = []
                });
            });

            var app = builder.Build();

            // ── Run migrations and seed data ──────────────────────────────────
            using (var scope = app.Services.CreateScope())
            {
                var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
                DbSeeder.Seed(db);
            }

            // ── Middleware Pipeline ───────────────────────────────────────────
            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "Smart Waste Management API v1");
                c.RoutePrefix = string.Empty; // Swagger UI opens at root URL
            });

            if (app.Environment.IsDevelopment())
            {
                // Development-only middleware can go here
            }

            app.UseHttpsRedirection();
            app.UseAuthentication(); // Must come BEFORE UseAuthorization
            app.UseAuthorization();
            app.MapControllers();

            app.Run();
        }
    }
}