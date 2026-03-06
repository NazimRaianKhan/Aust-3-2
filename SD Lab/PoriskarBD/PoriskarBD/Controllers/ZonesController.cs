using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartWasteManagement.DTOs;
using SmartWasteManagement.Interfaces;

namespace SmartWasteManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class ZonesController : ControllerBase
    {
        private readonly IZoneService _zoneService;

        public ZonesController(IZoneService zoneService)
        {
            _zoneService = zoneService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var zones = await _zoneService.GetAllAsync();
            return Ok(zones);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var zone = await _zoneService.GetByIdAsync(id);
            if (zone == null) return NotFound(new { message = "Zone not found." });
            return Ok(zone);
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create([FromBody] CreateZoneDto dto)
        {
            var zone = await _zoneService.CreateAsync(dto);
            return CreatedAtAction(nameof(GetById), new { id = zone.Id }, zone);
        }

        [HttpPut("{id}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Update(int id, [FromBody] CreateZoneDto dto)
        {
            var zone = await _zoneService.UpdateAsync(id, dto);
            if (zone == null) return NotFound(new { message = "Zone not found." });
            return Ok(zone);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Delete(int id)
        {
            var deleted = await _zoneService.DeleteAsync(id);
            if (!deleted) return NotFound(new { message = "Zone not found." });
            return Ok(new { message = "Zone deleted." });
        }
    }
}
