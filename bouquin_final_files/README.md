The code and resulting files from cleaning up the [Nanosatellites Database](http://www.nanosats.eu/) data are available on [GitHub](https://github.com/dbouquin/IS_608/tree/master/NanosatDB_munging)

Very minor edits to the files were made in Open Office due to the extremely unpredictable nature of issues in the data needing to be addressed. For example, there were a few cases of multiple date formats (e.g. 2016-10-30, 11/15/23) and mis-coded data (e.g. "Dubai" is not a "Nation"). These issues were able to be quickly recognized in Open Office so I could continue using R to further manipulate and structure the data. I contacted the database creator and he has since made updates to the data reflecting at least the date format changes I suggested. My data was pulled from the website on April 20, 2016.

All finished files are uploaded to GitHub and are downloaded directly from the repo when you run the [vis_final.Rmd file](https://github.com/dbouquin/IS_608/blob/master/vis_final.Rmd). The .Rmd file is not meant to be the final display of the charts though. Instead I pushed the charts up to be hosted on my Plotly account, from which I was able to generate embed codes to display the visualizations within my blog and elsewhere.

The final charts are visible [on my website](http://dainabouquin.com/608_final/).
