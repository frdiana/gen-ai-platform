using Microsoft.AspNetCore.Mvc;

namespace GenAiPlatform.Translation.Controllers;
[ApiController]
[Route("[controller]")]
public class TranslationController : ControllerBase
{
    private readonly ILogger<TranslationController> _logger;

    public TranslationController(ILogger<TranslationController> logger)
    {
        _logger = logger;
    }

    [HttpPost(Name = "translate")]
    public async Task<string> TranslateAsync([FromQuery] string from, [FromQuery]string to)
    {
        return await Task.FromResult($"Translating from {from} to {to}");
    }
}
