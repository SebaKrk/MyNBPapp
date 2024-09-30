//
//  AppleProductsJSON.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 29/09/2024.
//

import Foundation

let jsonAppleProducts =
 """
    {
      "products": [
        {
          "id": "1",
          "name": "iPhone 16",
          "price": 4999,
          "image": "https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/iphone-16-finish-select-202409-6-1inch_AV1?wid=5120&hei=2880&fmt=webp&qlt=70&.v=UXp1U3VDY3IyR1hNdHZwdFdOLzg1V0tFK1lhSCtYSGRqMUdhR284NTN4L2RJbmltQWhGZkQyVGNjT3IyemNOZWd2S3NaRzcrU0dmYjNHTUFiMnlsWFRocXAvNjVVaCtjTTZGTUNzOU8wNkVpZ3JSOHVOUHZSUHBkZzU2ZUh5WUo=&traceId=1"
        },
        {
          "id": "2",
          "name": "Przewód zasilający USB-C",
          "price": 99,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MQKJ3?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1701898734502"
        },
        {
          "id": "3",
          "name": "Zasilacz USB-C o mocy 20W",
          "price": 100,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MU7V2_GEO_EMEA?wid=266&hei=291&fmt=png-alpha&.v=1544468120362"
        },
        {
          "id": "4",
          "name": "Apple Watch 10",
          "price": 2399,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/watch-compare-series10-202409?wid=396&hei=468&fmt=jpeg&qlt=90&.v=1725360911927"
        },
        {
          "id": "5",
          "name": "Opaska żółta",
          "price": 249,
          "image": "https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/MY623ref?wid=5120&hei=3280&bgc=fafafa&trim=1&fmt=p-jpg&qlt=80&.v=RklTa2kxWjN6RVA2VklGN0ZrRmNLTHlqOGJhNEhuamM3dDluVGJ6bnZCcUNUZS9wMUc1eUlUVnRFYzlDc2lGTnJUTUgxNk5DUW5waUJSenV3d1lDMVNLdFVDUmF6QkV3WE5XdGZOcm1FbU09"
        },
        {
          "id": "6",
          "name": "Opaska czarna",
          "price": 249,
          "image": "https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/MY7N3ref?wid=5120&hei=3280&bgc=fafafa&trim=1&fmt=p-jpg&qlt=80&.v=YlVEUDhLWVplSlVDNWU1bktoS1RxTHlqOGJhNEhuamM3dDluVGJ6bnZCcUNUZS9wMUc1eUlUVnRFYzlDc2lGTnJUTUgxNk5DUW5waUJSenV3d1lDMWZDaXNxeDdOaGRmd1JIVVlOVit6SkU9"
        },
        {
          "id": "7",
          "name": "Ładowarka MagSafe (1 m)",
          "price": 179,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MX6X3_AV2?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1724109401530"
        },
        {
          "id": "8",
          "name": "Mac mini",
          "price": 3999,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/mac-mini-hero-202301?wid=904&hei=840&fmt=jpeg&qlt=90&.v=1670038314708"
        },
        {
          "id": "9",
          "name": "Studio Display",
          "price": 7499,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/studio-display-gallery-1-202203?wid=640&hei=528&fmt=p-jpg&qlt=95&.v=1675709041796"
        },
        {
          "id": "10",
          "name": "Zasilacz z dwoma portami USB-C o mocy 35 W",
          "price": 249,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MNWP3_GEO_EMEA?wid=1144&hei=1144&fmt=jpeg&qlt=95&.v=1653576603172"
        },
        {
          "id": "11",
          "name": "Klawiatura Magic Keyboard",
          "price": 599,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MK2C3Z?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1628010677000"
        },
        {
          "id": "12",
          "name": "Gładzik Magic Trackpad",
          "price": 499,
          "image": "https://www.apple.com/pl/shop/product/MK2D3ZM/A/gładzik-magic-trackpad-obszar-multi-touch-w-bieli?fnode=8a383fe574e76c513a232e4ec62e878abf9c085645b5fb22b8bdc64e90c6cddda99d8890abc18822fffbe2af441a79723994bbfe7f507f01297484f3278d5c12593b8402cb504a494185cfc4ecd8c918c3e4aca146134fee024850e82345a3ef"
        }
      ],
      "packages": [ ]
    }
"""

//{
//  "id": "1",
//  "name": "Zestaw iPhone + Ładowarka",
//  "items": [
//    { "productId": "1" },
//    { "productId": "3" }
//  ]
//},
//{
//  "id": "2",
//  "name": "Zestaw Mac mini + Klawiatura",
//  "items": [
//    { "productId": "8" },
//    { "productId": "11" }
//  ]
//},
//{
//  "id": "3",
//  "name": "Zestaw premium (iPhone + Ładowarka + Apple Watch)",
//  "items": [
//    { "packageId": "1" },
//    { "productId": "4" }
//  ]
//}
let jsonAppleProductsWithPackages =
"""
    {
      "products": [
        {
          "id": "1",
          "name": "iPhone 16",
          "price": 4999,
          "image": "https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/iphone-16-finish-select-202409-6-1inch_AV1?wid=5120&hei=2880&fmt=webp&qlt=70&.v=UXp1U3VDY3IyR1hNdHZwdFdOLzg1V0tFK1lhSCtYSGRqMUdhR284NTN4L2RJbmltQWhGZkQyVGNjT3IyemNOZWd2S3NaRzcrU0dmYjNHTUFiMnlsWFRocXAvNjVVaCtjTTZGTUNzOU8wNkVpZ3JSOHVOUHZSUHBkZzU2ZUh5WUo=&traceId=1"
        },
        {
          "id": "2",
          "name": "Przewód zasilający USB-C",
          "price": 99,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MQKJ3?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1701898734502"
        },
        {
          "id": "3",
          "name": "Zasilacz USB-C o mocy 20W",
          "price": 100,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MU7V2_GEO_EMEA?wid=266&hei=291&fmt=png-alpha&.v=1544468120362"
        },
        {
          "id": "4",
          "name": "Apple Watch 10",
          "price": 2399,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/watch-compare-series10-202409?wid=396&hei=468&fmt=jpeg&qlt=90&.v=1725360911927"
        },
        {
          "id": "5",
          "name": "Opaska żółta",
          "price": 249,
          "image": "https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/MY623ref?wid=5120&hei=3280&bgc=fafafa&trim=1&fmt=p-jpg&qlt=80&.v=RklTa2kxWjN6RVA2VklGN0ZrRmNLTHlqOGJhNEhuamM3dDluVGJ6bnZCcUNUZS9wMUc1eUlUVnRFYzlDc2lGTnJUTUgxNk5DUW5waUJSenV3d1lDMVNLdFVDUmF6QkV3WE5XdGZOcm1FbU09"
        },
        {
          "id": "6",
          "name": "Opaska czarna",
          "price": 249,
          "image": "https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/MY7N3ref?wid=5120&hei=3280&bgc=fafafa&trim=1&fmt=p-jpg&qlt=80&.v=YlVEUDhLWVplSlVDNWU1bktoS1RxTHlqOGJhNEhuamM3dDluVGJ6bnZCcUNUZS9wMUc1eUlUVnRFYzlDc2lGTnJUTUgxNk5DUW5waUJSenV3d1lDMWZDaXNxeDdOaGRmd1JIVVlOVit6SkU9"
        },
        {
          "id": "7",
          "name": "Ładowarka MagSafe (1 m)",
          "price": 179,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MX6X3_AV2?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1724109401530"
        },
        {
          "id": "8",
          "name": "Mac mini",
          "price": 3999,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/mac-mini-hero-202301?wid=904&hei=840&fmt=jpeg&qlt=90&.v=1670038314708"
        },
        {
          "id": "9",
          "name": "Studio Display",
          "price": 7499,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/studio-display-gallery-1-202203?wid=640&hei=528&fmt=p-jpg&qlt=95&.v=1675709041796"
        },
        {
          "id": "10",
          "name": "Zasilacz z dwoma portami USB-C o mocy 35 W",
          "price": 249,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MNWP3_GEO_EMEA?wid=1144&hei=1144&fmt=jpeg&qlt=95&.v=1653576603172"
        },
        {
          "id": "11",
          "name": "Klawiatura Magic Keyboard",
          "price": 599,
          "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MK2C3Z?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1628010677000"
        },
        {
          "id": "12",
          "name": "Gładzik Magic Trackpad",
          "price": 499,
          "image": "https://www.apple.com/pl/shop/product/MK2D3ZM/A/gładzik-magic-trackpad-obszar-multi-touch-w-bieli?fnode=8a383fe574e76c513a232e4ec62e878abf9c085645b5fb22b8bdc64e90c6cddda99d8890abc18822fffbe2af441a79723994bbfe7f507f01297484f3278d5c12593b8402cb504a494185cfc4ecd8c918c3e4aca146134fee024850e82345a3ef"
        }
      ],
      "packages": [
        {
          "id": "1",
          "name": "Zestaw iPhone + Ładowarka",
          "products": [
            {
              "id": "1",
              "name": "iPhone 16",
              "price": 4999,
              "image": "https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/iphone-16-finish-select-202409-6-1inch_AV1?wid=5120&hei=2880&fmt=webp&qlt=70&.v=UXp1U3VDY3IyR1hNdHZwdFdOLzg1V0tFK1lhSCtYSGRqMUdhR284NTN4L2RJbmltQWhGZkQyVGNjT3IyemNOZWd2S3NaRzcrU0dmYjNHTUFiMnlsWFRocXAvNjVVaCtjTTZGTUNzOU8wNkVpZ3JSOHVOUHZSUHBkZzU2ZUh5WUo=&traceId=1"
            },
            {
              "id": "3",
              "name": "Zasilacz USB-C o mocy 20W",
              "price": 100,
              "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MU7V2_GEO_EMEA?wid=266&hei=291&fmt=png-alpha&.v=1544468120362"
            }
          ]
        },
        {
          "id": "2",
          "name": "Zestaw Mac mini + Klawiatura",
          "products": [
            {
              "id": "8",
              "name": "Mac mini",
              "price": 3999,
              "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/mac-mini-hero-202301?wid=904&hei=840&fmt=jpeg&qlt=90&.v=1670038314708"
            },
            {
              "id": "11",
              "name": "Klawiatura Magic Keyboard",
              "price": 599,
              "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MK2C3Z?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1628010677000"
            }
          ]
        },
        {
          "id": "3",
          "name": "Zestaw premium (iPhone + Ładowarka + Apple Watch)",
          "products": [
            {
              "id": "1",
              "name": "iPhone 16",
              "price": 4999,
              "image": "https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/iphone-16-finish-select-202409-6-1inch_AV1?wid=5120&hei=2880&fmt=webp&qlt=70&.v=UXp1U3VDY3IyR1hNdHZwdFdOLzg1V0tFK1lhSCtYSGRqMUdhR284NTN4L2RJbmltQWhGZkQyVGNjT3IyemNOZWd2S3NaRzcrU0dmYjNHTUFiMnlsWFRocXAvNjVVaCtjTTZGTUNzOU8wNkVpZ3JSOHVOUHZSUHBkZzU2ZUh5WUo=&traceId=1"
            },
            {
              "id": "4",
              "name": "Apple Watch 10",
              "price": 2399,
              "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/watch-compare-series10-202409?wid=396&hei=468&fmt=jpeg&qlt=90&.v=1725360911927"
            }
          ]
        }
      ]
    }
"""
