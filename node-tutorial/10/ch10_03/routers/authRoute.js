const express = require("express");
const authContoller = require("../controllers/authController");

const router = express.Router();

// /auth
router.post("/register", authContoller.register);
router.post("/login", authContoller.login);
router.post("/refresh", authContoller.refresh);

module.exports = router;
