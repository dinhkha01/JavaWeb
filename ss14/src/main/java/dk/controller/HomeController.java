
package dk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.LocaleResolver;

import javax.servlet.http.HttpServletRequest;
import java.util.Locale;

@Controller
public class HomeController {

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private LocaleResolver localeResolver;
    @GetMapping("/home")
    public String homePage() {
        return "index";
    }

    @GetMapping("/")
    public String home(HttpServletRequest request, Model model) {
        // LocaleChangeInterceptor sẽ tự động xử lý ?lang=en hoặc ?lang=vi
        Locale currentLocale = localeResolver.resolveLocale(request);

        try {
            String welcomeMessage = messageSource.getMessage("welcome.message", null, currentLocale);
            String homeTitle = messageSource.getMessage("home.title", null, currentLocale);
            String languageLabel = messageSource.getMessage("language.label", null, currentLocale);
            String englishLabel = messageSource.getMessage("english.label", null, currentLocale);
            String vietnameseLabel = messageSource.getMessage("vietnamese.label", null, currentLocale);
            String aboutTitle = messageSource.getMessage("about.title", null, currentLocale);
            String aboutContent = messageSource.getMessage("about.content", null, currentLocale);
            String featuresTitle = messageSource.getMessage("features.title", null, currentLocale);
            String feature1 = messageSource.getMessage("feature.1", null, currentLocale);
            String feature2 = messageSource.getMessage("feature.2", null, currentLocale);
            String feature3 = messageSource.getMessage("feature.3", null, currentLocale);
            String contactTitle = messageSource.getMessage("contact.title", null, currentLocale);
            String contactContent = messageSource.getMessage("contact.content", null, currentLocale);

            // Thêm vào model
            model.addAttribute("welcomeMessage", welcomeMessage);
            model.addAttribute("homeTitle", homeTitle);
            model.addAttribute("languageLabel", languageLabel);
            model.addAttribute("englishLabel", englishLabel);
            model.addAttribute("vietnameseLabel", vietnameseLabel);
            model.addAttribute("aboutTitle", aboutTitle);
            model.addAttribute("aboutContent", aboutContent);
            model.addAttribute("featuresTitle", featuresTitle);
            model.addAttribute("feature1", feature1);
            model.addAttribute("feature2", feature2);
            model.addAttribute("feature3", feature3);
            model.addAttribute("contactTitle", contactTitle);
            model.addAttribute("contactContent", contactContent);
            model.addAttribute("currentLang", currentLocale.getLanguage());

        } catch (Exception e) {
            System.err.println("Error loading messages: " + e.getMessage());
            e.printStackTrace();

            // Fallback values
            model.addAttribute("welcomeMessage", "Welcome!");
            model.addAttribute("homeTitle", "Home");
            model.addAttribute("currentLang", currentLocale.getLanguage());
        }

        return "home";
    }
}