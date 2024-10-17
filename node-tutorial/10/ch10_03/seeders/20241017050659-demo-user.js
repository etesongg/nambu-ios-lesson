"use strict";

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.bulkInsert("Users", [
      {
        name: "song1",
        email: "song1@gmail.com",
        password: "song1234",
        address: "seoul, korea",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "song2",
        email: "song2@gmail.com",
        password: "song1234",
        address: "seoul, korea",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        name: "song3",
        email: "song3@gmail.com",
        password: "song1234",
        address: "seoul, korea",
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },

  async down(queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  },
};
