var aws = require("aws-sdk");
var ses = new aws.SES({ region: "us-west-2" });
exports.handler = async function (event) {
  var params = {
    Destination: {
      ToAddresses: ["omar2018.dev@gmail.com",],
    },
    Message: {
      Body: {
        Text: { Data: "Testtttttttttttttttttttttttt" },
      },

      Subject: { Data: "Test Email" },
    },
    Source: "omar.ud07.2016@gmail.com",
  };
 
  return ses.sendEmail(params).promise()
};