# README

### **Topic of the project:** `Beauty-Circle` is where you will find all beauty salons in one place. This application provides dashboard for registered beauty salons where they can edit their account, add appointments to calendar, create, edit or delete different procedures they provide.


### **Ruby version:** 2.7.3 ([check here](https://github.com/saruul0204/beauty-circle-app/blob/master/.ruby-version))
### **Rails version:** 6.1.4 ([check here](https://github.com/saruul0204/beauty-circle-app/blob/master/Gemfile))

### **System dependencies:** for this project, we need Ruby and Rails
- Ruby Installation: [Click here](https://www.ruby-lang.org/en/documentation/installation/)
- Rails Installation: [Click here](https://guides.rubyonrails.org/v5.0/getting_started.html)

### **Prerequisites:**
- Git
- Node
- Yarn
- Postgresql
- Terminal

### **Technologies used:**
- Ruby
- Rails
- TailwindCSS
### **How to launch `Beauty-Circle`?**
- Clone the [repository](https://github.com/saruul0204/beauty-circle-app.git)
- Make sure you have the suitable version for the project (as stated above)
    - Note: If you do not have the suitable versions installed, refer to the links above to find the steps for installation of Ruby and Rails
- Go to the correct directory
- Run the following commands:

```
bundle
yarn install
rails db:create && rails db:migrate && rails db:seed
rails server
```
- Open your browser and go to http://localhost:3000/