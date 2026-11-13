const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;
app.get("/", (req, res) => res.send("<h1>AI-Powered E-Commerce Store - DevOps Pipeline</h1>"));
app.get("/health", (req, res) => res.status(200).json({ status: "UP", timestamp: new Date() }));
app.listen(PORT, () => console.log("Server running on port " + PORT));
