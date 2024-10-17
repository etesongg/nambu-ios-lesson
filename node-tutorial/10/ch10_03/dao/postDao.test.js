const postDao = require("./postDao");

describe("Test", () => {
  test("should", async () => {
    const data = {
      title: "unit test dao",
      content: "unit test dao content",
      userId: 1,
    };
    const result = await postDao.createPost(data);
    expect(result.title).toBe(data.title);
  });
});
