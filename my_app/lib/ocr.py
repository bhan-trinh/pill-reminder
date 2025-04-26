from transformers import DonutProcessor, VisionEncoderDecoderModel
from PIL import ImageEnhance, Image, ImageFilter
import torch
import numpy as np

processor = DonutProcessor.from_pretrained("naver-clova-ix/donut-base-finetuned-docvqa", use_fast=True)
model = VisionEncoderDecoderModel.from_pretrained("naver-clova-ix/donut-base-finetuned-docvqa", torch_dtype=torch.float32, low_cpu_mem_usage=True)
model = model.to("cpu")

image = Image.open("label.png")
image = image.convert("L")
enhancer = ImageEnhance.Contrast(image)
image = enhancer.enhance(2.0)
image_array = np.array(image)
image_array = np.where(image_array > 150, 255, 0).astype(np.uint8)
image = Image.fromarray(image_array)
image = image.convert("RGB")
image = image.filter(ImageFilter.MedianFilter(size=3))

task_prompts = ["""
<s_docvqa><s_question>
Question: What is the dose of the medication (in milligrams)?
Answer:
</s_question><s_answer>
""",
"""
<s_docvqa><s_question>
Question: Question: What is the name of the medication (not the dosage)?
Answer:
</s_question><s_answer>
""",
"""
<s_docvqa><s_question>
Question: What are the full instructions for taking the medication (e.g., dosage frequency, timing, amount)?
Answer:
</s_question><s_answer>
"""
]
pixel_values = processor(image, return_tensors="pt").pixel_values
for i in range(0,3):
    decoder_input_ids = processor.tokenizer(task_prompts[i], add_special_tokens=False, return_tensors="pt").input_ids
    outputs = model.generate(pixel_values, decoder_input_ids=decoder_input_ids, max_length=512, pad_token_id=processor.tokenizer.pad_token_id)
    generated_text = processor.batch_decode(outputs, skip_special_tokens=True)[0]
    print(generated_text)

