# Superi.ge — საიტზე შესასრულებელი ფიქსები (NAP და schema)

**დამტკიცებული სამუშაო საათები:** ორშაბათი–კვირა, 09:00–21:00 (2026-10-10)

ყველა ცვლილება CS-Cart-ის ადმინ-პანელში კეთდება. ყოველი ცვლილების წინ ძველი ტექსტი შეინახეთ, რომ საჭიროების შემთხვევაში დააბრუნოთ.

---

## 1. Footer — HTML ბლოკი „კონტაქტი“ (block id 327)

**სად:** Design → Layouts → Default → footer → ბლოკი „კონტაქტი“

საათები footer-ში უკვე სწორია („ორშ-კვი 9:00 - 21:00“). შესაცვლელია მხოლოდ მისამართი.

| ძველი | ახალი |
|---|---|
| `მისამართი: თბილისი, მაჭავარიანის 62` | `მისამართი: თბილისი, მუხრან მაჭავარიანის ქ. 62` |

---

## 2. კონტაქტის გვერდი — https://superi.ge/contact/

**სად:** Website → Pages → კონტაქტი (ან ის ბლოკი, რომელშიც ეს ტექსტია)

| ძველი | ახალი |
|---|---|
| `ორშაბათი – შაბათი: 10:00 – 21:00` | `ორშაბათი – კვირა: 09:00 – 21:00` |

---

## 3. Schema — Organization JSON-LD `<head>`-ში

**სად:** ბლოკი, რომელიც იწყება `"@id": "https://superi.ge/#organization"`-ით. ის შეიძლება იყოს თემის შაბლონში, SEO add-on-ის პარამეტრებში ან head-ის custom კოდში.

`contactPoint`-ის პირველ ელემენტში (`"contactType": "customer service"`) შეცვალეთ მხოლოდ `hoursAvailable`.

**ძველი:**

```json
"hoursAvailable": {
  "@type": "OpeningHoursSpecification",
  "dayOfWeek": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
  "opens": "10:00",
  "closes": "21:00"
}
```

**ახალი:**

```json
"hoursAvailable": {
  "@type": "OpeningHoursSpecification",
  "dayOfWeek": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"],
  "opens": "09:00",
  "closes": "21:00"
}
```

იმავე ბლოკში `streetAddress` უკვე სწორია („მუხრან მაჭავარიანის 62“).

---

## 4. დუბლირებული schema-ს წაშლა (გვერდის ბოლოში)

`</body>`-მდე, WhatsApp ღილაკის სკრიპტის შემდეგ, ორი JSON-LD ბლოკია. ორივეს `@id` არ აქვს:

1. `{"@context":"https://schema.org","@type":"Organization","url":"https://superi.ge/","name":"Superi.ge", ... "sameAs":["https://www.facebook.com/Superi.ge"]}`
2. `{"@context":"https://schema.org","@type":"WebSite","url":"https://superi.ge/","potentialAction":[...]}`

მოძებნეთ, საიდან ემატება (CS-Cart add-on, თემა ან HTML ბლოკი footer-ში) და ორივე გამორთეთ ან წაშალეთ. `<head>`-ის ბლოკში Organization-იც და WebSite-იც უკვე არის, ამიტომ არაფერი დაიკარგება.

---

## 5. შემოწმება ცვლილებების შემდეგ

- [ ] https://superi.ge/ — footer: „ორშ-კვი 9:00 - 21:00“ და „მუხრან მაჭავარიანის ქ. 62“
- [ ] https://superi.ge/contact/ — „ორშაბათი – კვირა: 09:00 – 21:00“
- [ ] მთავარი გვერდის კოდში (view-source) `"@type": "Organization"` მხოლოდ ერთხელ გვხვდება და `"Sunday"` შეიცავს
- [ ] [Rich Results Test](https://search.google.com/test/rich-results) — მთავარი გვერდი შეცდომების გარეშე
- [ ] თუ საიტზე ქეში ჩართულია (Cloudflare, LiteSpeed), ცვლილებების შემდეგ გაასუფთავეთ

## 6. იგივე საათები სხვაგანაც

- Google Business Profile (როცა შეიქმნება)
- Facebook: `facebook.com/Superi.ge` → შესახებ → სამუშაო საათები
- yell.ge (ჩანაწერი 162718)
