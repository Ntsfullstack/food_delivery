class HTMLExample {
  HTMLExample._();

  static const String GG_MAP_KEY = "AIzaSyBiXrbrwJhCqACMPTFaiyeE3fwUMLnXOmI";


  String content = '''<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=0.8">
    <title>Receipt</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .column {
            float: left;
            width: 50%;
        }

        /* Clear floats after the columns */
        .row:after {
            content: "";
            display: table;
            clear: both;
        }

        .container {
            max-width: 600px;
            margin: auto;
        }

        header,
        footer {
            text-align: center;
            padding-bottom: 20px;
        }

        p,
        a {
            font-size: 1.5em;
            font-weight: 500;
        }

        section {
            padding: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th,
        td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;

            font-size: 1.5em;
            font-weight: 500;
        }

        th {
            background-color: #f2f2f2;
        }

        .recipt_title {
            text-align: center;
            font-size: 30px;
            padding-top: 10px;
            padding-bottom: 10px;
        }

        .summary {
            text-align: right;
            padding-top: 10px;
            padding-bottom: 10px;
            font-size: 1.5em;
            font-weight: 800;
        }
    </style>
</head>

<body>
    <div class="container">
        <header>
            <!-- <img src="[Your Company Logo]" alt="Company Logo" width="100"> -->

            <?xml version="1.0" encoding="utf-8"?>
            <!-- Generator: Adobe Illustrator 27.9.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
            <svg width="30%" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 200 58.3"
                style="enable-background:new 0 0 200 58.3;" xml:space="preserve">
                <style type="text/css">
                    .st0 {
                        fill: #1D76BB;
                    }
                </style>
                <g>
                    <path class="st0" d="M3.5,44.4c1.6,1.1,4.4,2.2,7.2,2.2c4,0,5.8-2,5.8-4.4c0-2.6-1.5-4-5.6-5.5C5.6,34.7,3,31.8,3,28.2
                    c0-4.8,3.9-8.8,10.3-8.8c3,0,5.7,0.9,7.4,1.9l-1.4,4c-1.2-0.7-3.3-1.7-6.1-1.7c-3.2,0-5,1.9-5,4.1c0,2.5,1.8,3.6,5.7,5.1
                    c5.2,2,7.8,4.6,7.8,9c0,5.2-4.1,9-11.2,9c-3.3,0-6.3-0.8-8.4-2L3.5,44.4z" />
                    <path class="st0"
                        d="M35.3,11.5v8.6h7.8v4.1h-7.8v16.1c0,3.7,1.1,5.8,4.1,5.8c1.4,0,2.5-0.2,3.2-0.4l0.2,4.1
                    c-1.1,0.4-2.7,0.7-4.8,0.7c-2.5,0-4.6-0.8-5.9-2.3C30.5,46.7,30,44,30,40.5V24.2h-4.6v-4.1H30v-7.2L35.3,11.5z" />
                    <path class="st0" d="M65.7,50l-0.4-3.8h-0.2c-1.7,2.3-4.9,4.4-9.1,4.4c-6,0-9.1-4.3-9.1-8.6c0-7.2,6.4-11.2,18-11.1v-0.6
                    c0-2.5-0.7-6.9-6.8-6.9c-2.8,0-5.7,0.9-7.8,2.2L49,22.1c2.5-1.6,6-2.7,9.8-2.7c9.1,0,11.4,6.2,11.4,12.2v11.2
                    c0,2.6,0.1,5.1,0.5,7.2H65.7z M64.9,34.7c-5.9-0.1-12.7,0.9-12.7,6.7c0,3.5,2.3,5.2,5.1,5.2c3.9,0,6.4-2.5,7.2-5
                    c0.2-0.6,0.3-1.2,0.3-1.7L64.9,34.7L64.9,34.7z" />
                    <path class="st0"
                        d="M78.9,29.4c0-3.5-0.1-6.5-0.2-9.3h4.8l0.2,5.9h0.2c1.4-4,4.6-6.5,8.3-6.5c0.6,0,1.1,0.1,1.5,0.2v5.1
                    c-0.6-0.1-1.1-0.2-1.9-0.2c-3.8,0-6.5,2.9-7.3,7c-0.1,0.7-0.2,1.6-0.2,2.5V50h-5.4L78.9,29.4L78.9,29.4z" />
                    <path class="st0" d="M99.3,8.8c2.6-0.4,6-0.8,10.3-0.8c5.3,0,9.2,1.2,11.7,3.5c2.3,2,3.6,5,3.6,8.7c0,3.8-1.1,6.7-3.2,8.9
                    c-2.8,3-7.5,4.6-12.7,4.6c-1.6,0-3.1-0.1-4.3-0.4V50h-5.4L99.3,8.8L99.3,8.8z M104.7,28.9c1.2,0.3,2.7,0.4,4.4,0.4
                    c6.5,0,10.4-3.2,10.4-8.9c0-5.5-3.9-8.2-9.8-8.2c-2.3,0-4.1,0.2-5.1,0.4L104.7,28.9L104.7,28.9z" />
                    <path class="st0" d="M167.8,28.7c0,14.3-8.7,21.9-19.3,21.9c-11,0-18.7-8.5-18.7-21.1c0-13.2,8.2-21.9,19.3-21.9
                    C160.4,7.7,167.8,16.4,167.8,28.7z M135.5,29.4c0,8.9,4.8,16.9,13.3,16.9c8.5,0,13.3-7.8,13.3-17.3c0-8.3-4.3-16.9-13.3-16.9
                    C139.9,12.1,135.5,20.3,135.5,29.4z" />
                    <path class="st0" d="M174,43.4c2.4,1.5,5.9,2.7,9.6,2.7c5.5,0,8.7-2.9,8.7-7.1c0-3.9-2.2-6.1-7.8-8.3c-6.8-2.4-11-5.9-11-11.8
                    c0-6.5,5.4-11.3,13.5-11.3c4.3,0,7.4,1,9.2,2l-1.5,4.4c-1.4-0.7-4.1-2-7.9-2c-5.7,0-7.8,3.4-7.8,6.2c0,3.9,2.5,5.8,8.3,8
                    c7,2.7,10.6,6.1,10.6,12.2c0,6.4-4.8,12-14.6,12c-4,0-8.4-1.2-10.6-2.7L174,43.4z" />
                </g>
            </svg>


            <h1>[Company Name]</h1>
            <p>[Address Line 1]
                <br>[Address Line 2]
                <br>[City, State, Zip Code]
                <br>Phone: [Phone Number]
                <br>Email: [Email Address]
            </p>
        </header>

        <div>
            <h1 id="recipt_title" class="recipt_title">HOÁ ĐƠN THANH TOÁN</h1>
            <p id="order_number">Order Number: XYZ12345
                <br id="date_time">Date: [Date and Time]
                <br id="cashier">Cashier: [Cashier Name]
            </p>

            <table>
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Product 1</td>
                        <td>2</td>
                        <td>\$10.00</td>
                        <td>\$20.00</td>
                    </tr>
                    <tr>
                        <td>Product 2</td>
                        <td>1</td>
                        <td>\$25.00</td>
                        <td>\$25.00</td>
                    </tr>
                    <tr>
                        <td>Product 3</td>
                        <td>3</td>
                        <td>\$8.50</td>
                        <td>\$25.50</td>
                    </tr>
                </tbody>
            </table>


            <div class="row">
                <p style="text-align: right; padding-right: 15px;" id=" sub_total">Subtotal: 0.50<br id="tax">Tax
                    (8%):
                    \$5.64<br id="total">Total: <span class="total_value"
                        style="font-weight: bold; font-size: 1.5em;">\$76.14</span></p>

            </div>


            <div style="text-align: center;">
                <div class="qrcode">
                    <img
                        src="data:image/png;base64,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">
                </div>

            </div>


            <footer>
                <p>Thank You!<br>We appreciate your business.<br>Please come back again soon!</p>
                <p id="company_name">[Your Company]<br id="company_website">[Website URL]</p>
            </footer>

        </div>
</body>

</html>''';

}

