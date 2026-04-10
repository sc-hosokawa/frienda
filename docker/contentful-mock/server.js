const express = require("express");
const app = express();
const PORT = 3100;

// Sample news entries for local development
const sampleEntries = {
  sys: { type: "Array" },
  total: 2,
  skip: 0,
  limit: 100,
  items: [
    {
      sys: {
        id: "mock-entry-1",
        type: "Entry",
        contentType: { sys: { id: "news" } },
        createdAt: "2025-01-01T00:00:00.000Z",
        updatedAt: "2025-01-01T00:00:00.000Z",
      },
      fields: {
        title: "[Mock] サンプルニュース記事 1",
        slug: "sample-news-1",
        body: "これはローカル開発用のモックニュース記事です。",
        publishedAt: "2025-01-01T00:00:00.000Z",
      },
    },
    {
      sys: {
        id: "mock-entry-2",
        type: "Entry",
        contentType: { sys: { id: "news" } },
        createdAt: "2025-02-01T00:00:00.000Z",
        updatedAt: "2025-02-01T00:00:00.000Z",
      },
      fields: {
        title: "[Mock] サンプルニュース記事 2",
        slug: "sample-news-2",
        body: "これはローカル開発用のモックニュース記事です。Contentful の代替として動作します。",
        publishedAt: "2025-02-01T00:00:00.000Z",
      },
    },
  ],
};

// Bearer token existence check (mirrors Contentful CDA auth requirement)
app.use("/spaces", (req, res, next) => {
  const auth = req.headers.authorization;
  if (!auth || !auth.startsWith("Bearer ")) {
    return res.status(401).json({
      sys: { type: "Error", id: "AccessTokenInvalid" },
      message: "Authorization header with Bearer token is required",
    });
  }
  next();
});

// GET /spaces/:spaceId/environments/:envId/entries
app.get("/spaces/:spaceId/environments/:envId/entries", (_req, res) => {
  res.json(sampleEntries);
});

// GET /spaces/:spaceId/environments/:envId/entries/:entryId
app.get(
  "/spaces/:spaceId/environments/:envId/entries/:entryId",
  (req, res) => {
    const entry = sampleEntries.items.find(
      (e) => e.sys.id === req.params.entryId
    );
    if (entry) {
      res.json(entry);
    } else {
      res.status(404).json({ sys: { type: "Error", id: "NotFound" } });
    }
  }
);

// Health check
app.get("/health", (_req, res) => {
  res.json({ status: "ok", service: "contentful-mock" });
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Contentful mock server running on port ${PORT}`);
});
