"""Test Nova Pro in eu-west-2"""
import os
import asyncio
from dotenv import load_dotenv
from agents import Agent, Runner, trace
from agents.extensions.models.litellm_model import LitellmModel

load_dotenv()

async def test_nova_pro():
    # Set region for LiteLLM
    os.environ["AWS_REGION_NAME"] = "eu-west-2"
    os.environ["AWS_REGION"] = "eu-west-2"
    os.environ["AWS_DEFAULT_REGION"] = "eu-west-2"
    
    print("Testing Nova Pro in eu-west-2 (London)...")
    print(f"Model: amazon.nova-pro-v1:0")
    print(f"Region: {os.environ['AWS_REGION_NAME']}")
    
    try:
        model = LitellmModel(model="bedrock/amazon.nova-pro-v1:0")
        
        with trace("Test"):
            agent = Agent(
                name="Test Agent",
                instructions="You are a helpful assistant. Be very brief.",
                model=model
            )
            
            result = await Runner.run(
                agent,
                input="Say 'Hello from Nova Pro in London!' and nothing else.",
                max_turns=1
            )
            
            print(f"\n✅ SUCCESS!")
            print(f"Response: {result.final_output}")
            return True
            
    except Exception as e:
        print(f"\n❌ FAILED!")
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    asyncio.run(test_nova_pro())
