// Mobile menu toggle
const menuBtn = document.getElementById('mobile-menu-btn');
const mobileMenu = document.getElementById('mobile-menu');

menuBtn.addEventListener('click', () => {
    mobileMenu.classList.toggle('hidden');
});

// Navigation bar active link
document.addEventListener("DOMContentLoaded", function () {
    const links = document.querySelectorAll("nav a");  
    const currentPage = window.location.pathname.split("/").pop();  

    links.forEach(link => {
        if (link.getAttribute("href") === currentPage) {
            link.classList.add("text-blue-400", "font-semibold");  
        } else {
            link.classList.remove("text-blue-400", "font-semibold");
            link.classList.add("text-gray-300", "hover:text-blue-400");
        }
    });
});

// Contact form functionality
            function sendEmail(event) {
            event.preventDefault();
            
            // Get form values
            const name = document.getElementById('senderName').value;
            const email = document.getElementById('senderEmail').value;
            const subject = document.getElementById('emailSubject').value;
            const message = document.getElementById('emailMessage').value;
            
        
            const yourEmail = 'nomakhwezimalusi@gmail.com'; // Change this to your email
            
            // Create email body
            const emailBody = `Name: ${name}%0D%0AEmail: ${email}%0D%0A%0D%0AMessage:%0D%0A${message}`;
            
            // Create mailto link
            const mailtoLink = `mailto:${yourEmail}?subject=${encodeURIComponent(subject)}&body=${emailBody}`;
            
            // Show loading state
            const button = document.getElementById('sendButton');
            const originalText = button.innerHTML;
            button.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Opening Email...';
            button.disabled = true;
            
            // Open email client
            window.location.href = mailtoLink;
            
            // Reset button after a delay
            setTimeout(() => {
                button.innerHTML = originalText;
                button.disabled = false;
                
                // Show success message
                alert('Email client opened! If it didn\'t open automatically, please copy this email address: ' + yourEmail);
                
                // Optional: Clear form
                document.getElementById('contactForm').reset();
            }, 2000);
        }
