using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PoriskarBD.Migrations
{
    /// <inheritdoc />
    public partial class FixStaticSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                column: "PasswordHash",
                value: "$2a$11$9G7T5vKnByGaHOGHnSs4IOXSRi7e2PBjFlQVnMU5Ts5dr7RrxMMKu");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                column: "PasswordHash",
                value: "$2a$11$cy0A0OpTfm0V6MGHbe9kyehnVx1kYfPS8iUMYhb5LQvBGDZJVfzMy");
        }
    }
}
