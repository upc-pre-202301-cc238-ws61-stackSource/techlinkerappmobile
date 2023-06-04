class JobOffer {
  String ? id;
  String ? title;
  String ? description;
  String ? company;
  String ? location;
  String ? image;
  String ? requirement;
  JobOffer(
      {required this.id,
        required this.title,
        required this.description,
        required this.company,
        required this.location,
        required this.image,
        required this.requirement});

  static List<JobOffer> jobOffers() {
    return [
      JobOffer(
          id: "01",
          title: "Backend Developer",
          description: "We are looking for a Back-End Web Developer responsible for managing the interchange of data between the server and the users. Your primary focus will be development of all server-side logic, definition and maintenance of the central database, and ensuring high performance and responsiveness to requests from the front-end. You will also be responsible for integrating the front-end elements built by your coworkers into the application. A basic understanding of front-end technologies is therefore necessary as well.",
          company: "Google",
          location: "San Isidro, 243",
          image:
          "https://www.simplilearn.com/ice9/free_resources_article_thumb/How_to_Become_a_Back_End_Developer.jpg",
          requirement: "Bachelor's degree in Computer Science or related field, or equivalent experience. 3+ years of experience in software development. Experience in developing web applications using at least one popular web framework (JSF, Wicket, GWT, Spring MVC). Experience with test-driven development."),
      JobOffer(
          id: "02",
          title: "Frontend Developer",
          description: "We are looking for a Front-End Web Developer who is motivated to combine the art of design with the art of programming. Responsibilities will include translation of the UI/UX design wireframes to actual code that will produce visual elements of the application. You will work with the UI/UX designer and bridge the gap between graphical design and technical implementation, taking an active role on both sides and defining how the application looks as well as how it works.",
          company: "Facebook",
          location: "San Isidro, 100",
          image:
          "https://media.licdn.com/dms/image/D5612AQG2wFDFDltiNg/article-cover_image-shrink_720_1280/0/1675322684139?e=2147483647&v=beta&t=R_9OphmuNCHhnP3GTyVyOtlHqxxF8CFBIdJTyGz98Rw",
          requirement: "Bachelor's degree in Computer Science or related field, or equivalent experience. 3+ years of experience in software development. Experience in developing web applications using at least one popular web framework (JSF, Wicket, GWT, Spring MVC). Experience with test-driven development."),
      JobOffer(
          id: "03",
          title: "Fullstack Developer",
          description: "We are looking for a Full Stack Developer to produce scalable software solutions. You’ll be part of a cross-functional team that’s responsible for the full software development life cycle, from conception to deployment. As a Full Stack Developer, you should be comfortable around both front-end and back-end coding languages, development frameworks and third-party libraries. You should also be a team player with a knack for visual design and utility.",
          company: "Amazon",
          location: "San Miguel, 123",
          image:
          "https://thetapacademy.com/wp-content/uploads/2022/10/full-stack-web-developer-1024x1024.jpg",
          requirement: "Bachelor's degree in Computer Science or related field, or equivalent experience. 3+ years of experience in software development. Experience in developing web applications using at least one popular web framework (JSF, Wicket, GWT, Spring MVC). Experience with test-driven development."),
          JobOffer(
          id: "04",
          title: "Mobile Developer",
          description: "We are looking for a Mobile Developer who is motivated to combine the art of design with the art of programming. Responsibilities will include translation of the UI/UX design wireframes to actual code that will produce visual elements of the application. You will work with the UI/UX designer and bridge the gap between graphical design and technical implementation, taking an active role on both sides and defining how the application looks as well as how it works.",
          company: "Apple",
          location: "San Isidro, 243",
          image:
          "https://assets-global.website-files.com/6410ebf8e483b5bb2c86eb27/6410ebf8e483b5758186fbd8_ABM%20college%20mobile%20app%20dev%20main.jpg",
          requirement: "Bachelor's degree in Computer Science or related field, or equivalent experience. 3+ years of experience in software development. Experience in developing web applications using at least one popular web framework (JSF, Wicket, GWT, Spring MVC). Experience with test-driven development."),
      JobOffer(
          id: "05",
          title: "Data Scientist",
          description: "We are looking for a Data Scientist who will support our product, sales, leadership and marketing teams with insights gained from analyzing company data. The ideal candidate is adept at using large data sets to find opportunities for product and process optimization and using models to test the effectiveness of different courses of action. They must have strong experience using a variety of data mining/data analysis methods, using a variety of data tools, building and implementing models, using/creating algorithms and creating/running simulations. They must have a proven ability to drive business results with their data-based insights. They must be comfortable working with a wide range of stakeholders and functional teams. The right candidate will have a passion for discovering solutions hidden in large data sets and working with stakeholders to improve business outcomes.",
          company: "Google",
          location: "San Isidro, 243",
          image:
          "https://www.analyticsinsight.net/wp-content/uploads/2021/08/7-Benefits-of-Data-Science.jpg",
          requirement: "Bachelor's degree in Computer Science or related field, or equivalent experience. 3+ years of experience in software development. Experience in developing web applications using at least one popular web framework (JSF, Wicket, GWT, Spring MVC). Experience with test-driven development."),
      JobOffer(
          id: "06",
          title: "DevOps Engineer",
          description: "We are looking for a DevOps Engineer to help us build functional systems that improve customer experience. DevOps Engineer responsibilities include deploying product updates, identifying production issues and implementing integrations that meet customer needs. If you have a solid background in software engineering and are familiar with Ruby or Python, we’d like to meet you. Ultimately, you will execute and automate operational processes fast, accurately and securely.",
          company: "Facebook",
          location: "San Isidro, 100",
          image:
          "https://www.codemotion.com/magazine/wp-content/uploads/2020/09/devops-1024x527.png",
          requirement: "Bachelor's degree in Computer Science or related field, or equivalent experience. 3+ years of experience in software development. Experience in developing web applications using at least one popular web framework (JSF, Wicket, GWT, Spring MVC). Experience with test-driven development."),
    ];

  }

}