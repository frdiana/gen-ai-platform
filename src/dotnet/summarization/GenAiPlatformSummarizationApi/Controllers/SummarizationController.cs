using Microsoft.AspNetCore.Mvc;

namespace GenAiPlatformSummarizationApi.Controllers;
[ApiController]
[Route("[controller]")]
public class SummarizationController : ControllerBase
{
    private readonly ILogger<SummarizationController> _logger;

    public SummarizationController(ILogger<SummarizationController> logger) => _logger = logger;

    [HttpGet]
    [Route("summarize")]
    public Task<string> SummarizeAsync()
    {
        return Task.FromResult($"Summarizing the text");
    }
}
