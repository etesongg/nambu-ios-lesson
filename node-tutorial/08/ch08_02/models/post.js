module.exports = (sequelize, DataTypes) => {
  /* create table Post(
        id integer primary key autoincrement,
        title TEXT not null,
        content varchar,
        author varchar(50),
        ) 
   */
  const Post = sequelize.define("Post", {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    title: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    content: DataTypes.STRING,
    author: DataTypes.STRING(50),
  });
  return Post;
};
