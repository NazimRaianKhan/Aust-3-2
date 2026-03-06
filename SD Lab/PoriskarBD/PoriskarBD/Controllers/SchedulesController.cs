using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SmartWasteManagement.DTOs;
using SmartWasteManagement.Interfaces;

namespace SmartWasteManagement.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class SchedulesController : ControllerBase
    {
        private readonly IScheduleService _scheduleService;

        public SchedulesController(IScheduleService scheduleService)
        {
            _scheduleService = scheduleService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var schedules = await _scheduleService.GetAllAsync();
            return Ok(schedules);
        }

        [HttpGet("zone/{zoneId}")]
        public async Task<IActionResult> GetByZone(int zoneId)
        {
            var schedules = await _scheduleService.GetByZoneAsync(zoneId);
            return Ok(schedules);
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Create([FromBody] CreateScheduleDto dto)
        {
            var (success, message, data) = await _scheduleService.CreateAsync(dto);
            if (!success) return BadRequest(new { message });
            return CreatedAtAction(nameof(GetAll), new { }, data);
        }

        [HttpPut("{id}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Update(int id, [FromBody] CreateScheduleDto dto)
        {
            var (success, message, data) = await _scheduleService.UpdateAsync(id, dto);
            if (!success) return BadRequest(new { message });
            return Ok(data);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Delete(int id)
        {
            var deleted = await _scheduleService.DeleteAsync(id);
            if (!deleted) return NotFound(new { message = "Schedule not found." });
            return Ok(new { message = "Schedule deleted." });
        }
    }
}
