# Color Palette Reference

## Primary Colors

### Gold / Accent
```
HEX: #D4AF37
RGB: (212, 175, 55)
HSL: (49°, 66%, 52%)
CMYK: (0%, 25%, 75%, 17%)
Pantone: 16-1531 TCX
```

### Deep Blue / Primary Text & Background
```
HEX: #1A2E4A
RGB: (26, 46, 74)
HSL: (211°, 48%, 20%)
CMYK: (65%, 38%, 0%, 71%)
Pantone: 19-4025 TCX
```

### Tech Purple / Secondary Accent
```
HEX: #6B5B95
RGB: (107, 91, 149)
HSL: (264°, 25%, 47%)
CMYK: (28%, 39%, 0%, 42%)
Pantone: 18-3943 TCX
```

---

## Secondary Colors

### Bronze / Tertiary
```
HEX: #CD7F32
RGB: (205, 127, 50)
HSL: (27°, 61%, 50%)
CMYK: (0%, 38%, 76%, 20%)
Use: Trophy base, secondary awards
```

### Silver / Accent
```
HEX: #C0C0C0
RGB: (192, 192, 192)
HSL: (0°, 0%, 75%)
CMYK: (0%, 0%, 0%, 25%)
Use: Tertiary accents, badges
```

---

## Neutral Colors

### Light Gray / Background
```
HEX: #F5F5F5
RGB: (245, 245, 245)
HSL: (0°, 0%, 96%)
CMYK: (0%, 0%, 0%, 4%)
Use: Page backgrounds, subtle sections
```

### Medium Gray / Borders & Dividers
```
HEX: #E8E8E8
RGB: (232, 232, 232)
HSL: (0°, 0%, 91%)
CMYK: (0%, 0%, 0%, 9%)
Use: Border lines, separation
```

### Dark Gray / Secondary Text
```
HEX: #4A4A4A
RGB: (74, 74, 74)
HSL: (0°, 0%, 29%)
CMYK: (0%, 0%, 0%, 71%)
Use: Body text, secondary content
```

### Black
```
HEX: #000000
RGB: (0, 0, 0)
HSL: (0°, 0%, 0%)
CMYK: (0%, 0%, 0%, 100%)
Use: Primary text, outlines, strong contrast
```

### White
```
HEX: #FFFFFF
RGB: (255, 255, 255)
HSL: (0°, 0%, 100%)
CMYK: (0%, 0%, 0%, 0%)
Use: Text on dark backgrounds, highlights
```

---

## Color Combinations (Approved Pairings)

### For Light Backgrounds
```
Text: #1A2E4A (Deep Blue)
Accent: #D4AF37 (Gold)
Highlights: #6B5B95 (Purple)
Borders: #E8E8E8 (Medium Gray)
```

### For Dark Backgrounds
```
Text: #FFFFFF (White)
Accent: #FFD700 (Brighter Gold)
Highlights: #A499D9 (Lighter Purple)
Borders: #2A2A2A (Dark Gray)
```

### Button Gradients
```
Primary Button: #D4AF37 → #B8860B (Gold to Bronze)
Hover State: #FFD700 → #D4AF37 (Bright Gold to Gold)
Text: #1A2E4A (Deep Blue)
```

### Badge/Award Backgrounds
```
Best Overall: Linear gradient #1A2E4A → #2A4E6A (Deep Blue tones)
Most Useful: Linear gradient #D4AF37 → #CD7F32 (Gold to Bronze)
Most Beautiful: Linear gradient #6B5B95 → #8B7FD9 (Purple tones)
Most Original: Linear gradient #D4AF37 → #6B5B95 (Gold to Purple)
```

---

## Accessibility & Contrast Ratios

### WCAG AA Compliant (4.5:1 minimum for text)

| Combination | Ratio | Status |
|-------------|-------|--------|
| #1A2E4A on #FFFFFF | 12.2:1 | ✅ AAA |
| #D4AF37 on #1A2E4A | 6.8:1 | ✅ AAA |
| #6B5B95 on #FFFFFF | 5.2:1 | ✅ AAA |
| #4A4A4A on #FFFFFF | 8.0:1 | ✅ AAA |
| #D4AF37 on #FFFFFF | 4.8:1 | ✅ AA |
| #FFFFFF on #D4AF37 | 4.8:1 | ✅ AA |
| #FFFFFF on #1A2E4A | 12.2:1 | ✅ AAA |

---

## Color Usage Guidelines

### Do's ✅
- Use gold (#D4AF37) for CTAs and highlights
- Combine deep blue with gold for premium feel
- Use purple for tech/AI elements
- Apply white text on dark backgrounds
- Use gradients sparingly (headers, buttons only)

### Don'ts ❌
- Don't use gold text on white backgrounds (low contrast)
- Don't mix all accent colors together
- Don't use purple as primary text color
- Don't fade colors below 50% opacity without reason
- Don't use highly saturated versions of these colors

---

## Digital Color Codes

### CSS Variables (Copy-paste friendly)
```css
:root {
  --color-gold: #D4AF37;
  --color-gold-bright: #FFD700;
  --color-bronze: #CD7F32;
  --color-blue-dark: #1A2E4A;
  --color-purple: #6B5B95;
  --color-purple-light: #8B7FD9;
  --color-gray-light: #F5F5F5;
  --color-gray-medium: #E8E8E8;
  --color-gray-dark: #4A4A4A;
  --color-text-primary: #1A2E4A;
  --color-text-secondary: #4A4A4A;
  --color-white: #FFFFFF;
  --color-black: #000000;
}
```

### Tailwind CSS Classes (if using Tailwind)
```javascript
colors: {
  'ore-gold': '#D4AF37',
  'ore-blue': '#1A2E4A',
  'ore-purple': '#6B5B95',
  'ore-bronze': '#CD7F32',
}
```

### JavaScript/React
```javascript
export const colors = {
  primary: {
    gold: '#D4AF37',
    blue: '#1A2E4A',
    purple: '#6B5B95',
  },
  secondary: {
    bronze: '#CD7F32',
    silver: '#C0C0C0',
  },
  neutral: {
    lightGray: '#F5F5F5',
    mediumGray: '#E8E8E8',
    darkGray: '#4A4A4A',
  },
};
```

---

## Gradient Definitions

### Gold Gradient (Primary Accent)
```css
background: linear-gradient(135deg, #FFD700 0%, #D4AF37 100%);
```

### Deep Blue Gradient (Header Background)
```css
background: linear-gradient(135deg, #1A2E4A 0%, #2A4E6A 100%);
```

### Purple Gradient (Secondary Accent)
```css
background: linear-gradient(135deg, #6B5B95 0%, #8B7FD9 100%);
```

### Award Badge Gradient
```css
background: linear-gradient(135deg, #D4AF37 0%, #CD7F32 100%);
```

---

## Print Color Specifications

For professional printing, use these specifications:

### CMYK (Subtractive - for printing)
- **Gold**: C: 0%, M: 25%, Y: 75%, K: 17%
- **Deep Blue**: C: 65%, M: 38%, Y: 0%, K: 71%
- **Purple**: C: 28%, M: 39%, Y: 0%, K: 42%

### Pantone (For branded materials)
- **Gold**: Pantone 16-1531 TCX
- **Deep Blue**: Pantone 19-4025 TCX
- **Purple**: Pantone 18-3943 TCX

---

**Last Updated**: July 2026  
**Version**: 1.0
