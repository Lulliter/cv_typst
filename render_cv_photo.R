# This one renders cv_photo.pdf and send it PDFs directly to docs/*
quarto::quarto_render("cv.qmd",
							 metadata = list(`profile-photo` = "assets/img/profile.jpg"),
							 output_file = "cv_photo.pdf")
