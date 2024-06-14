using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace GenAiPlatform.FrontendApi.Controllers;
[Route("api/[controller]")]
[ApiController]
public class HealthController : ControllerBase
{
    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public IActionResult Get()
    {
        return Ok();
    }
}
