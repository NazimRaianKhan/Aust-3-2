using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PoriskarBD.Migrations
{
    /// <inheritdoc />
    public partial class RemoveAdminSeed1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "Email", "Name", "PasswordHash", "Role", "ZoneId" },
                values: new object[] { 1, "admin@waste.com", "Admin", "$2a$11$9G7T5vKnByGaHOGHnSs4IOXSRi7e2PBjFlQVnMU5Ts5dr7RrxMMKu", 2, null });
        }
    }
}
