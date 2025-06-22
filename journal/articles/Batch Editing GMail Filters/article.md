# Batch Editing GMail Filters

<!-- Created 6/21/2025 -->

I have a number of job alert email subscriptions from different employers, but not all job alerts can be customized at the employer's website, so I get emails with irrelevant job openings. For this, I have created GMail filters, because I'm getting them at my GMail address, which search for specific terms.

At this point I have close to 40 or 50 such filters, and when I discover a new term I want to add or remove from all filters, it becomes laborious. GMail allows the export of filters to as an XML file, and this article details my attempt to programmatically manipulate those filters.

# 6/21/2025

My effort begins by using *Python*'s *BeautifulSoup* to manipulate the XML files. This is implemented in [**Python Package/src/herman_code/gmail_filter.py**](../../../Python%20Package/src/herman_code/gmail_filter.py).

After a few hours, the effort results too difficult, so I will save it as a commit on different branch.
