var commentData = [  
  // Add more comments as needed
  {
    timestamp: "2 hours ago",
    username: "JohnDoe",
    pinID: 1,
    text: "This is a comment about the pin.",
    replies: [
      {
        timestamp: "1 hour ago",
        username: "Alice",
        pinID: 1,
        text: "Reply to John's comment.",
      },
      {
        timestamp: "1 hour ago",
        username: "Alice",
        pinID: 1,
        text: "Reply to John's comment.",
      },
    ],
  },
  {
    timestamp: "30 minutes ago",
    username: "JaneSmith",
    pinID: 2,
    text: "Another comment about a different pin.",
    replies: [],
  },
];

const handleTime = (dataD) => {
  let data= new Date(dataD)
  let hrs = data.getHours()
  let mins = data.getMinutes()
  if(hrs<=9)
     hrs = '0' + hrs
  if(mins<10)
    mins = '0' + mins
  const postTime= hrs + ':' + mins
  return postTime
}

function addComment( username,pinID, text) {
  var newComment = {
    timestamp: "Just now", // You can use a function to get the current timestamp
    username: username, // Replace with the actual username
    pinID: pinID,
    text: text,
    replies: [],
  };

  // Add the new comment to the beginning of the array
  console.log(newComment.pinID)
  commentData.push(newComment);

}

function getCommentData() {
  return commentData;
}

function addReply(parentIndex, text) {
  var newReply = {
    timestamp: "Just now", // You can use a function to get the current timestamp
    username: "CurrentUsername", // Replace with the actual username
    pinID: commentData[parentIndex].pinID,
    text: text,
  };
  commentData[parentIndex].replies.push(newReply);
}
