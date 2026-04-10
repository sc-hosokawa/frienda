const express = require("express");
const app = express();
const PORT = 3101;

app.use(express.json());

// POST /v1beta/models/:model:generateContent
app.post("/v1beta/models/:model\\:generateContent", (req, res) => {
  const model = req.params.model;
  const prompt =
    req.body?.contents?.[0]?.parts?.[0]?.text || "(no prompt provided)";

  res.json({
    candidates: [
      {
        content: {
          parts: [
            {
              text: `[Mock Gemini Response] Model: ${model}, Prompt received: "${prompt.substring(0, 100)}"... This is a mock response for local development.`,
            },
          ],
          role: "model",
        },
        finishReason: "STOP",
        index: 0,
      },
    ],
    usageMetadata: {
      promptTokenCount: 10,
      candidatesTokenCount: 30,
      totalTokenCount: 40,
    },
  });
});

// POST /v1/models/:model:generateContent (v1 endpoint)
app.post("/v1/models/:model\\:generateContent", (req, res) => {
  const model = req.params.model;
  const prompt =
    req.body?.contents?.[0]?.parts?.[0]?.text || "(no prompt provided)";

  res.json({
    candidates: [
      {
        content: {
          parts: [
            {
              text: `[Mock Gemini Response] Model: ${model}, Prompt received: "${prompt.substring(0, 100)}"... This is a mock response for local development.`,
            },
          ],
          role: "model",
        },
        finishReason: "STOP",
        index: 0,
      },
    ],
    usageMetadata: {
      promptTokenCount: 10,
      candidatesTokenCount: 30,
      totalTokenCount: 40,
    },
  });
});

// Health check
app.get("/health", (_req, res) => {
  res.json({ status: "ok", service: "gemini-mock" });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Gemini mock server running on port ${PORT}`);
});
