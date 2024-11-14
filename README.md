# Stock Dashboard
<div align="center">
  <img src="https://github.com/user-attachments/assets/aac19b24-c6e9-4e74-965a-00571c7df86d"/>
</div>


Stock Dashboard is a macOS application designed to help you quickly fetch and view stock information for major companies. With a clean, elegant UI, Stock Dashboard allows users to search by stock symbol and view key information such as company name, stock price, and sector, along with the company's logo.

## Features

- **Simple and Elegant UI**: The app provides a straightforward interface with a rounded input field for stock symbol search and a button to fetch data.
- **Real-time Stock Information**: Fetches data from the Financial Modeling Prep API, including stock price, company name, sector, and company logo.
- **Minimalist Design**: Inspired by macOS aesthetics, Stock Dashboard is designed to be visually appealing and easy to use.

## Screenshots

### Opening Window
![Opening Window](https://github.com/user-attachments/assets/5483109c-d838-4e43-af81-0cb128058663)

The main window displays a search field for entering stock symbols and a "Fetch Info" button to retrieve stock data.

### Searching for TSLA
![Searching TSLA](https://github.com/user-attachments/assets/a426d306-c20e-49f0-8d17-1cef11f35e43)

When you enter a valid stock symbol like "TSLA" and click "Fetch Info," the app displays the company name, current price, sector, and logo.

## How to Run

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/sunami09/TickerSearchMacOS
   ```

2. **Navigate to the Application Folder**:
   ```bash
   cd TickerSearchMacOS
   ```

3. **Run the App**:
   - Inside the folder, locate the `Stock Dashboard.app` file.
   - Double-click `Stock Dashboard.app` to launch the application.

*Note*: This application is unsigned, so macOS may show a warning when you try to open it. To bypass this warning:
   - Right-click the app and select **Open**, then confirm in the dialog box.
   - Alternatively, go to **System Preferences > Security & Privacy > General** and click **Open Anyway** if prompted.

## Technical Details

- **Language**: Objective-C
- **Framework**: Cocoa
- **Data Source**: [Financial Modeling Prep API](https://financialmodelingprep.com)
- **Requirements**: macOS (compatible with both Apple Silicon and Intel-based Macs)

## Future Improvements

- **Additional Data**: Display more details about the stock and company, like market cap, beta, and volume.
- **Favorites**: Add functionality to save frequently searched stocks.
- **Historical Data**: Show historical stock data and trends.

## License

This project is licensed under the MIT License
