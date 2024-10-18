const express = require("express");
const postContoller = require("../controllers/postContoller");
const { authenticatieToken } = require("../middleware/auth_middleware");
const router = express.Router();

// /posts
router.post("/", authenticatieToken, postContoller.createPost);
router.get("/", postContoller.findAllPost);
router.get("/:id", postContoller.findPostById);
router.put("/:id", postContoller.updatePost);
router.delete("/:id", postContoller.deletePost);

module.exports = router;
